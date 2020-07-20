#include "logger.h"
#include <Arduino.h>


#ifndef BUTTON_PIN
	#define BUTTON_PIN 25
#endif


namespace button {
	void init();
	void loop();
	int getDebounceDelay();
	int getLastDebounceTime();
	bool buttonStateChanged();
	bool buttonStateHigh();
	void updateBottonState();
	void updateLastButtonState();
}
