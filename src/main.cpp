#include "main.h"

void setup() {
	Serial.begin(MONITOR_SPEED);
	sdcard::init();
	logger::write("Bleskomat firmware version=" + firmwareVersion + ",commit=" + firmwareCommitHash);
	config::init();
	logger::write("Config OK");
	network::init();
	logger::write("Network OK");
	modules::init();
	logger::write("Modules OK");
	logger::write("Setup OK");
}

float amountShown = 0;

void loop() {
	network::loop();
	modules::loop();
	const std::string currentScreen = screen::getCurrentScreen();
	double buyLimit = config::getBuyLimit();
	float accumulatedValue = 0;
	#ifdef COIN_ACCEPTOR
		accumulatedValue += coinAcceptor::getAccumulatedValue();
	#endif
	#ifdef BILL_ACCEPTOR
		accumulatedValue += billAcceptor::getAccumulatedValue();
		float billAcceptorEscrowValue = billAcceptor::getEscrowValue();
		if (billAcceptorEscrowValue > 0 && billAcceptorEscrowValue + accumulatedValue > buyLimit) {
			billAcceptor::rejectEscrow();
		} else if (billAcceptorEscrowValue > 0) {
			billAcceptor::acceptEscrow();
		}
	#endif
	if (
		accumulatedValue > 0 &&
		currentScreen != "insertFiat" &&
		currentScreen != "transactionComplete"
	) {
		screen::showInsertFiatScreen(accumulatedValue);
		amountShown = accumulatedValue;
	}
	#ifdef WIFI_ACCESS_POINT
		wifiAccessPoint::loop();
		if (wifiAccessPoint::isAvailable()) {
			// WiFi access point is currently available.
			if (wifiAccessPoint::hasClientsConnected()) {
				// At least one client is currently connected.
				// Show the WiFi access point open web interface screen, if not already shown.
				if (currentScreen != "wifiAccessPointOpenWebInterface") {
					screen::showWifiAccessPointOpenWebInterfaceScreen(
						wifiAccessPoint::getURL()
					);
				}
			}else {
				// No clients connected.
				// Show the WiFi access point connection details screen, if not already shown.
				if (currentScreen != "wifiAccessPointConnectionDetails") {
					screen::showWifiAccessPointConnectionDetailsScreen(
						wifiAccessPoint::getSSID(),
						wifiAccessPoint::getPassword(),
						wifiAccessPoint::getConfigurationString()
					);
				}
			}
			// Use button to stop the access point.
			if (button::wasPressedAndReleased(500)) {
				wifiAccessPoint::stop();
			}
			// Stop WiFi access point automatically after set time limit.
			if (wifiAccessPoint::getTimeAvailable() >= 300000) {
				wifiAccessPoint::stop();
			}
		} else {
			// WiFi access point is not currently available.
			// Show the splash screen, if any of the WiFi access point screens are currently shown.
			if (
				currentScreen == "wifiAccessPointConnectionDetails" ||
				currentScreen == "wifiAccessPointOpenWebInterface"
			) {
				screen::showSplashScreen();
			}
			// Use button to start the WiFi access point.
			if (button::getTimePressed() >= 3000) {
				wifiAccessPoint::start();
			}
		}
	#endif
	if (currentScreen == "splash") {
		if (button::wasPressedAndReleased(500)) {
			screen::showInstructionsScreen();
		}
	} else if (currentScreen == "instructions") {
		if (button::wasPressedAndReleased(500)) {
			screen::showInsertFiatScreen(0);
		}
	} else if (currentScreen == "insertFiat") {
		if (button::wasPressedAndReleased(500)) {
			if (accumulatedValue > 0) {
				// Button pushed while insert fiat screen shown and accumulated value greater than 0.
				// Generate random words that will be displayed to the user as a human-friendly proof/reference code.
				const std::string referenceCode = util::generateRandomWords(5);
				// Create a withdraw request and render it as a QR code.
				const std::string signedUrl = util::createSignedWithdrawUrl(accumulatedValue, referenceCode);
				const std::string encoded = util::lnurlEncode(signedUrl);
				const std::string uriSchemaPrefix = config::get("uriSchemaPrefix");
				std::string qrcodeData = "";
				if (uriSchemaPrefix != "") {
					// Allows upper or lower case URI schema prefix via a configuration option.
					// Some wallet apps might not support uppercase URI prefixes.
					qrcodeData += uriSchemaPrefix + ":";
				}
				// QR codes with only uppercase letters are less complex (easier to scan).
				qrcodeData += util::toUpperCase(encoded);
				screen::showTransactionCompleteScreen(accumulatedValue, qrcodeData, referenceCode);
				// Save the transaction for debugging and auditing purposes.
				logger::logTransaction(signedUrl);
				#ifdef COIN_ACCEPTOR
					coinAcceptor::off();
				#endif
				#ifdef BILL_ACCEPTOR
					billAcceptor::off();
				#endif
			} else {
				// Button pressed with zero amount.
				screen::showInstructionsScreen();
			}
		} else {
			// Button not pressed.
			// Ensure that the amount shown is correct.
			if (amountShown != accumulatedValue) {
				screen::updateInsertFiatScreenAmount(accumulatedValue);
				amountShown = accumulatedValue;
			}
			#ifdef COIN_ACCEPTOR
				float maxCoinValue = coinAcceptor::getMaxCoinValue();
				if (buyLimit > 0 && coinAcceptor::isOn() && (accumulatedValue + maxCoinValue) > buyLimit) {
					// Possible to exceed tx limit, so disallow entering more coins.
					coinAcceptor::off();
				}
			#endif
		}
	} else if (currentScreen == "transactionComplete") {
		if (button::wasPressedAndReleased(500)) {
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
