#include "modules/button.h"

namespace {
	bool pressed = false;
	int lastState;
	unsigned long lastStateChangeTime = 0;// Last time the button pin was toggled.
	unsigned long debounceDelay = 50;// Debounce time; increase it if the output flickers
	unsigned long lastPressedTime = 0;
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
					lastPressedTime = millis();
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

	bool wasPressedAndReleased(const unsigned long &maxPressedTime) {
		return !pressed && lastPressedTime > 0 && (maxPressedTime == 0 || (millis() - lastPressedTime) < maxPressedTime);
	}

	unsigned long getTimePressed() {
		if (pressed) {
			return millis() - lastStateChangeTime;
		}
		return 0;
	}
}
