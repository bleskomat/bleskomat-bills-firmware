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
		if (accumulatedValue > 0) {
			const unsigned long billTimeSinceLastInserted = billAcceptor::getTimeSinceLastInserted();
			const unsigned long coinTimeSinceLastInserted = coinAcceptor::getTimeSinceLastInserted();
			if (
				(
					billAccumulatedValue == 0 ||
					billTimeSinceLastInserted >= minWaitTimeSinceInsertedFiat
				) &&
				(
					coinAccumulatedValue == 0 ||
					coinTimeSinceLastInserted >= minWaitTimeSinceInsertedFiat
				)
			) {
				// The minimum required wait time between bills/coins has passed.
				// Create a withdraw request and render it as a QR code.
				printf("billAccumulatedValue: %f\n", billAccumulatedValue);
				printf("coinAccumulatedValue: %f\n", coinAccumulatedValue);
				printf("accumulatedValue: %f\n", accumulatedValue);
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
			} else {
				// Fiat was inserted, but timer has not run out yet.
				unsigned long timeSinceLastInserted = 0;
				if (billTimeSinceLastInserted > 0 && coinTimeSinceLastInserted > 0) {
					if (billTimeSinceLastInserted < coinTimeSinceLastInserted) {
						timeSinceLastInserted = billTimeSinceLastInserted;
					} else {
						timeSinceLastInserted = coinTimeSinceLastInserted;
					}
				} else if (billTimeSinceLastInserted > 0) {
					timeSinceLastInserted = billTimeSinceLastInserted;
				} else if (coinTimeSinceLastInserted > 0) {
					timeSinceLastInserted = coinTimeSinceLastInserted;
				}
				unsigned long timeRemaining = 0;
				if (minWaitTimeSinceInsertedFiat > timeSinceLastInserted) {
					timeRemaining = minWaitTimeSinceInsertedFiat - timeSinceLastInserted;
				}
				printf("timeRemaining: %ld\n", timeRemaining);
				printf("timeSinceLastInserted: %ld\n", timeSinceLastInserted);
				if (timeRemaining > 1000 && timeSinceLastInserted > 5000) {
					display::updateTimer(timeRemaining);
				} else {
					display::clearTimer();
				}
			}
		}
		if (!display::hasRenderedQRCode() && display::getRenderedAmount() != accumulatedValue) {
			display::updateAmount(accumulatedValue, config::fiatCurrency);
		}
	}
}
