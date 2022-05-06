#include "main.h"

void setup() {
	Serial.begin(MONITOR_SPEED);
	sdcard::init();
	logger::write(firmwareName);
	logger::write("Firmware version = " + firmwareVersion + ", commit hash = " + firmwareCommitHash);
	config::init();
	logger::write("Config OK");
	network::init();
	logger::write("Network OK");
	modules::init();
	logger::write("Modules OK");
	logger::write("Setup OK");
}

float getAccumulatedValue() {
	float accumulatedValue = 0;
	#ifdef COIN_ACCEPTOR
		accumulatedValue += coinAcceptor::getAccumulatedValue();
	#endif
	#ifdef BILL_ACCEPTOR
		accumulatedValue += billAcceptor::getAccumulatedValue();
		const float billAcceptorEscrowValue = billAcceptor::getEscrowValue();
		if (billAcceptorEscrowValue > 0) {
			const double buyLimit = config::getBuyLimit();
			if (billAcceptorEscrowValue + accumulatedValue > buyLimit) {
				billAcceptor::rejectEscrow();
			} else {
				billAcceptor::acceptEscrow();
				accumulatedValue += billAcceptorEscrowValue;
			}
		}
	#endif
	return accumulatedValue;
}

float amountShown = 0;

void runAppLoop() {
	// Un-comment the following to enable extra debugging information:
	// debugger::loop();
	sdcard::loop();
	network::loop();
	pingServer::loop();
	platform::loop();
	modules::loop();
	const std::string currentScreen = screen::getCurrentScreen();
	if (currentScreen == "" && screen::isReady()) {
		if (config::isEnabled()) {
			screen::showSplashScreen();
			modules::enableAcceptors();
		} else {
			screen::showDisabledScreen();
			modules::disableAcceptors();
		}
	}
	const float accumulatedValue = getAccumulatedValue();
	const bool tradeInProgress = (
		accumulatedValue > 0 &&
		(
			currentScreen == "insertFiat" ||
			currentScreen == "tradeComplete"
		)
	);
	if (
		// Do not disable device when a trade is in progress.
		!tradeInProgress &&
		(
			// Device is disabled via configuration option.
			!config::isEnabled() ||
			// Or, platform is down.
			network::platformIsDown()
		)
	) {
		// Show device disabled screen and do not allow normal operation.
		if (currentScreen != "disabled") {
			modules::disableAcceptors();
			screen::showDisabledScreen();
		}
	} else {
		// Device is enabled.
		if (currentScreen == "disabled") {
			// Previously disabled, return to normal operation.
			screen::showSplashScreen();
			modules::enableAcceptors();
		}
		if (
			accumulatedValue > 0 &&
			currentScreen != "insertFiat" &&
			currentScreen != "tradeComplete"
		) {
			screen::showInsertFiatScreen(accumulatedValue);
			amountShown = accumulatedValue;
		}
		if (currentScreen == "splash") {
			if (button::isPressed()) {
				screen::showInstructionsScreen();
			}
		} else if (currentScreen == "instructions") {
			if (button::isPressed()) {
				screen::showInsertFiatScreen(0);
			}
		} else if (currentScreen == "insertFiat") {
			if (button::isPressed()) {
				if (accumulatedValue > 0) {
					// Button pushed while insert fiat screen shown and accumulated value greater than 0.
					// Generate random words that will be displayed to the user as a human-friendly proof/reference code.
					const std::string referencePhrase = util::generateRandomPhrase(5);
					Lnurl::Query customParams;
					customParams["r"] = referencePhrase;
					const double exchangeRate = platform::getExchangeRate();
					if (exchangeRate > 0) {
						customParams["er"] = std::to_string(exchangeRate);
					}
					// Create a withdraw request and render it as a QR code.
					const std::string signedUrl = util::createSignedLnurlWithdraw(accumulatedValue, customParams);
					const std::string encoded = util::lnurlEncode(signedUrl);
					std::string qrcodeData = "";
					// Allows upper or lower case URI schema prefix via a configuration option.
					// Some wallet apps might not support uppercase URI prefixes.
					qrcodeData += config::get("uriSchemaPrefix");
					// QR codes with only uppercase letters are less complex (easier to scan).
					qrcodeData += util::toUpperCase(encoded);
					screen::showTradeCompleteScreen(accumulatedValue, qrcodeData, referencePhrase);
					// Save the transaction for debugging and auditing purposes.
					logger::write(signedUrl, "trade");
					modules::disableAcceptors();
				} else {
					// Button pressed with zero amount.
					screen::showInstructionsScreen();
				}
			} else {
				// Button not pressed.
				// Ensure that the amount shown is correct.
				if (amountShown != accumulatedValue) {
					screen::showInsertFiatScreen(accumulatedValue);
					amountShown = accumulatedValue;
				}
				#ifdef COIN_ACCEPTOR
					const float maxCoinValue = coinAcceptor::getMaxCoinValue();
					const double buyLimit = config::getBuyLimit();
					if (buyLimit > 0 && coinAcceptor::isOn() && (accumulatedValue + maxCoinValue) > buyLimit) {
						// Possible to exceed tx limit, so disallow entering more coins.
						coinAcceptor::off();
					}
				#endif
			}
		} else if (currentScreen == "tradeComplete") {
			if (button::isPressed()) {
				// Button pushed while showing the transaction complete screen.
				// Reset accumulated values.
				#ifdef COIN_ACCEPTOR
					coinAcceptor::reset();
					coinAcceptor::on();
				#endif
				#ifdef BILL_ACCEPTOR
					billAcceptor::reset();
					billAcceptor::on();
				#endif
				amountShown = 0;
				screen::showSplashScreen();
			}
		}
	}
}

void loop() {
	jsonRpc::loop();
	if (!jsonRpc::inUse()) {
		runAppLoop();
	}
}
