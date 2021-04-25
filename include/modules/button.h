#ifndef BLESKOMAT_MODULES_BUTTON_ACCEPTOR_H
#define BLESKOMAT_MODULES_BUTTON_ACCEPTOR_H

#include "logger.h"

#include <Arduino.h>

#ifndef BUTTON_PIN
	#define BUTTON_PIN 33
#endif

namespace button {
	void init();
	void loop();
	bool isPressed();
	bool wasPressedAndReleased(const unsigned long &maxPressedTime = 0);
	unsigned long getTimePressed();
}

#endif
