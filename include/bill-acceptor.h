#ifndef BLESKOMAT_BILL_ACCEPTOR_H
#define BLESKOMAT_BILL_ACCEPTOR_H

#include "config.h"
#include "logger.h"
#include "util.h"
#include <HardwareSerial.h>
#include <deque>
#include <map>

namespace billAcceptor {
	void init();
	void loop();
	void inhibit();
	void disinhibit();
	float getAccumulatedValue();
	float getEscrowValue();
	void acceptEscrow();
	void rejectEscrow();
	void resetAccumulatedValue();
	void setAccumulatedValue(float value);
	bool isConnected();
}

#endif
