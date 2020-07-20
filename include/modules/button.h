#include "logger.h"
#include <Arduino.h>

#ifndef BUTTON_PIN
	#define BUTTON_PIN 25
#endif

namespace button {
	void init();
	void loop();
	bool pushed();
}
