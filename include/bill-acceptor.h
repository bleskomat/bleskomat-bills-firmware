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
	float getAccumulatedValue();
	float getEscrowValue();
	void clearEscrowValue();
	void enableEscrow();
	void acceptEscrow();
	void rejectEscrow();
	void resetAccumulatedValue();
	void setAccumulatedValue(float value);
	void inhibit();
	void disinhibit();
}

#endif
