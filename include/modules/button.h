#ifndef BLESKOMAT_MODULES_BUTTON_H
#define BLESKOMAT_MODULES_BUTTON_H

#include "logger.h"

#include <Arduino.h>

#ifndef BUTTON_PIN
	#define BUTTON_PIN 33
#endif

namespace button {
	void init();
	void loop();
	bool isPressed();
}

#endif
