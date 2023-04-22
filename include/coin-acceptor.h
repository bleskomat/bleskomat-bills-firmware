#ifndef BLESKOMAT_COIN_ACCEPTOR_H
#define BLESKOMAT_COIN_ACCEPTOR_H

#include "config.h"
#include "logger.h"
#include "util.h"

#include <HardwareSerial.h>

#include <deque>

namespace coinAcceptor {
	void init();
	void loop();
	float getAccumulatedValue();
	void resetAccumulatedValue();
	bool isInhibited();
	void inhibit();
	void disinhibit();
}

#endif
