#ifndef BLESKOMAT_MODULES_COIN_ACCEPTOR_H
#define BLESKOMAT_MODULES_COIN_ACCEPTOR_H

#include "config.h"
#include "logger.h"
#include "util.h"

#include <HardwareSerial.h>

#include <deque>

#ifndef COIN_ACCEPTOR_RX_PIN
	#define COIN_ACCEPTOR_RX_PIN 16
#endif

#ifndef COIN_ACCEPTOR_INHIBITING_PIN
	#define COIN_ACCEPTOR_INHIBITING_PIN 21
#endif

#ifndef COIN_ACCEPTOR_DATA_RATE
	#define COIN_ACCEPTOR_DATA_RATE 9600
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
