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
	logger::write("Setup OK");
}

const unsigned long bootTime = millis();// milliseconds
const unsigned long minWaitAfterBootTime = 2000;// milliseconds
const unsigned long minWaitTimeBetweenCoins = 7000;// milliseconds
const unsigned long maxTimeDisplayQrCode = 60000;// milliseconds

void loop() {
	if (millis() - bootTime >= minWaitAfterBootTime) {
		// Minimum time has passed since boot.
		// Start performing checks.
		coinAcceptor::loop();
		if (coinAcceptor::coinInserted() && display::hasRenderedQRCode()) {
			// Clear the QR code when new coins are inserted.
			display::clearQRCode();
		}
		if (display::getTimeSinceRenderedQRCode() >= maxTimeDisplayQrCode) {
			// Automatically clear the QR code from the screen after some time has passed.
			display::clearQRCode();
		}
		float accumulatedValue = coinAcceptor::getAccumulatedValue();
		if (coinAcceptor::getTimeSinceLastCoinInserted() >= minWaitTimeBetweenCoins) {
			// The minimum required wait time between coins has passed.
			// Create a withdraw request and render it as a QR code.
			std::string req = lnurl::create_signed_withdraw_request(
				accumulatedValue,
				config::fiatCurrency,
				config::apiKeyId,
				config::apiKeySecret,
				config::callbackUrl
			);
			display::renderQRCode("lightning:" + req);
			coinAcceptor::reset();
		}
		if (!display::hasRenderedQRCode() && display::getRenderedAmount() != accumulatedValue) {
			display::updateAmount(accumulatedValue, config::fiatCurrency);
		}
	}
}
