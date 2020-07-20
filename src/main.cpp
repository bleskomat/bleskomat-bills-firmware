#include <string>
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
	modules::init();
	logger::write("Modules OK");
	logger::write("Setup OK");
}

float lastAccumulatedValue = 0;
unsigned long accumulatedValueChangeTime = 0;
unsigned long accumulatedValueDebounceTime = 400;// milliseconds

void loop() {
	modules::loop();
	float accumulatedValue = 0;
	#ifdef COIN_ACCEPTOR
		accumulatedValue += coinAcceptor::getAccumulatedValue();
	#endif
	#ifdef BILL_ACCEPTOR
		accumulatedValue += billAcceptor::getAccumulatedValue();
	#endif
	if (accumulatedValue != lastAccumulatedValue) {
		// Accumulated value has changed.
		accumulatedValueChangeTime = millis();
	}
	if (button::pushed() && (millis() - accumulatedValueChangeTime) > accumulatedValueDebounceTime) {
		if (display::hasRenderedQRCode()) {
			// Button pushed while already displaying a QR code.
			// Clear the QR code and reset accumulated value.
			#ifdef COIN_ACCEPTOR
				coinAcceptor::reset();
			#endif
			#ifdef BILL_ACCEPTOR
				billAcceptor::reset();
			#endif
			display::clearQRCode();
		} else if (accumulatedValue > 0) {
			// Button pushed while no QR code displayed and accumulated value greater than 0.
			// Create a withdraw request and render it as a QR code.
			std::string req = lnurl::create_signed_withdraw_request(
				accumulatedValue,
				config::fiatCurrency,
				config::apiKeyId,
				config::apiKeySecret,
				config::callbackUrl
			);
			display::renderQRCode("lightning:" + req);
		}
	} else {
		// Button not pressed.
		// Ensure that the displayed accumulated value is correct.
		if (accumulatedValue != display::getRenderedAmount()) {
			display::updateAmount(accumulatedValue, config::fiatCurrency);
		}
	}
	lastAccumulatedValue = accumulatedValue;
}
