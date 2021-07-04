#ifndef BLESKOMAT_MODULES_COIN_ACCEPTOR_H
#define BLESKOMAT_MODULES_COIN_ACCEPTOR_H

#include "config.h"
#include "logger.h"
#include "util.h"

#include <HardwareSerial.h>

#include <deque>

#ifndef COIN_ACCEPTOR_SIGNAL
	#define COIN_ACCEPTOR_SIGNAL 16
#endif

#ifndef COIN_ACCEPTOR_INHIBIT
	#define COIN_ACCEPTOR_INHIBIT 21
#endif

#ifndef COIN_ACCEPTOR_BAUDRATE
	#define COIN_ACCEPTOR_BAUDRATE 9600
#endif

namespace coinAcceptor {
	void init();
	void loop();
	float getAccumulatedValue();
	float getMaxCoinValue();
	void reset();
	bool isOff();
	bool isOn();
	void on();
	void off();
}

#endif
