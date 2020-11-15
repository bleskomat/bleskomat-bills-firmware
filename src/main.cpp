#include "config.h"
#include "display.h"
#include "logger.h"
#include "modules.h"
#include "util.h"

#include <lnurl.h>
#include <string>

void setup() {
	Serial.begin(115200);
	logger::enable();
	sdcard::init();
	config::init();
	logger::write("Config OK");
	display::init();
	display::updateAmount(0.00, config::getConfig().fiatCurrency);
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
				coinAcceptor::on();
			#endif
			#ifdef BILL_ACCEPTOR
				billAcceptor::reset();
			#endif
			display::clearQRCode();
		} else if (accumulatedValue > 0) {
			// Button pushed while no QR code displayed and accumulated value greater than 0.
			// Create a withdraw request and render it as a QR code.
			const std::string req = util::createSignedWithdrawRequest(accumulatedValue);
			// Convert to uppercase because it reduces the complexity of the QR code.
			display::renderQRCode("LIGHTNING:" + util::toUpperCase(req));
			#ifdef COIN_ACCEPTOR
				coinAcceptor::off();
			#endif
		}
	} else {
		// Button not pressed.
		// Ensure that the displayed accumulated value is correct.
		if (accumulatedValue != display::getRenderedAmount()) {
			display::updateAmount(accumulatedValue, config::getConfig().fiatCurrency);
		}
	}
	lastAccumulatedValue = accumulatedValue;
}
