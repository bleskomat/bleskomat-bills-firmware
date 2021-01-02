#include "modules/button.h"

namespace {
	bool pressed = false;
	int lastState;
	unsigned long lastStateChangeTime = 0;// Last time the button pin was toggled.
	unsigned long debounceDelay = 50;// Debounce time; increase it if the output flickers
}

namespace button {

	void init() {
		pinMode(BUTTON_PIN, INPUT);
	}

	void loop() {
		const int state = digitalRead(BUTTON_PIN);
		if ((millis() - lastStateChangeTime) > debounceDelay) {
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
