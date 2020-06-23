#include <string>
#include "config.h"
#include "display.h"
#include "logger.h"
#include "lnurl.h"
#include "modules.h"

void setup() {
	Serial.begin(115200);
	logger::enable();
	config::init();
	logger::write("Config OK");
	display::init();
	display::updateAmount(0.00, config::fiatCurrency);
	logger::write("Display OK");
	coinAcceptor::init();
	coinAcceptor::setFiatCurrency(config::fiatCurrency);
	logger::write("Coin Reader OK");
	billAcceptor::init();
	billAcceptor::setFiatCurrency(config::fiatCurrency);
	logger::write("Bill Reader OK");
	logger::write("Setup OK");
}

const unsigned long bootTime = millis();// milliseconds
const unsigned long minWaitAfterBootTime = 2000;// milliseconds
const unsigned long minWaitTimeSinceInsertedFiat = 15000;// milliseconds
const unsigned long maxTimeDisplayQrCode = 120000;// milliseconds

void loop() {
	if (millis() - bootTime >= minWaitAfterBootTime) {
		// Minimum time has passed since boot.
		// Start performing checks.
		billAcceptor::loop();
		coinAcceptor::loop();
		if (display::getTimeSinceRenderedQRCode() >= maxTimeDisplayQrCode) {
			// Automatically clear the QR code from the screen after some time has passed.
			display::clearQRCode();
		} else if (coinAcceptor::coinInserted() && display::hasRenderedQRCode()) {
			// Clear the QR code when new coins are inserted.
			display::clearQRCode();
		} else if (billAcceptor::billInserted() && display::hasRenderedQRCode()) {
			// Clear the QR code when new bills are inserted.
			display::clearQRCode();
		}
		float billAccumulatedValue = billAcceptor::getAccumulatedValue();
		float coinAccumulatedValue = coinAcceptor::getAccumulatedValue();
		float accumulatedValue = billAccumulatedValue + coinAccumulatedValue;
		if (
			accumulatedValue > 0 &&
			(
				billAccumulatedValue == 0 ||
				billAcceptor::getTimeSinceLastInserted() >= minWaitTimeSinceInsertedFiat
			) &&
			(
				coinAccumulatedValue == 0 ||
				coinAcceptor::getTimeSinceLastInserted() >= minWaitTimeSinceInsertedFiat
			)
		) {
			printf("billAccumulatedValue: %f\n", billAccumulatedValue);
			printf("coinAccumulatedValue: %f\n", coinAccumulatedValue);
			printf("accumulatedValue: %f\n", accumulatedValue);
			// The minimum required wait time between bills/coins has passed.
			// Create a withdraw request and render it as a QR code.
			std::string req = lnurl::create_signed_withdraw_request(
				accumulatedValue,
				config::fiatCurrency,
				config::apiKeyId,
				config::apiKeySecret,
				config::callbackUrl
			);
			display::renderQRCode("lightning:" + req);
			billAcceptor::reset();
			coinAcceptor::reset();
		}
		if (!display::hasRenderedQRCode() && display::getRenderedAmount() != accumulatedValue) {
			display::updateAmount(accumulatedValue, config::fiatCurrency);
		}
	}
}
