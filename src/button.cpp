#include "button.h"

namespace {
	bool pressed = false;
	int lastState;
	unsigned long lastStateChangeTime = 0;// Last time the button pin was toggled.
	unsigned int debounceDelay;// Debounce time; increase it if the output flickers
	unsigned short pinNumber;
}

namespace button {

	void init() {
		logger::write("Initializing button...");
		debounceDelay = config::getUnsignedInt("buttonDebounce");
		pinNumber = config::getUnsignedShort("buttonPin");
		pinMode(pinNumber, INPUT);
	}

	void loop() {
		if ((millis() - lastStateChangeTime) > debounceDelay) {
			const int state = digitalRead(pinNumber);
			if (state != lastState) {
				if (state == HIGH) {
					pressed = true;
					logger::write("Button pressed");
				} else {
					pressed = false;
					logger::write("Button released");
				}
				// Reset the debouncing timer.
				// We track time in order to avoid noise state changes.
				lastStateChangeTime = millis();
				lastState = state;
			}
		}
	}

	bool isPressed() {
		return pressed;
	}
}
