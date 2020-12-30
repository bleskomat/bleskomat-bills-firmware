#ifndef BLESKOMAT_MODULES_BILL_ACCEPTOR_H
#define BLESKOMAT_MODULES_BILL_ACCEPTOR_H

#include "config.h"
#include "logger.h"
#include "util.h"

#include <HardwareSerial.h>

#ifndef BILL_ACCEPTOR_RX_PIN
	#define BILL_ACCEPTOR_RX_PIN 9
#endif

#ifndef BILL_ACCEPTOR_TX_PIN
	#define BILL_ACCEPTOR_TX_PIN 10
#endif

#ifndef BILL_ACCEPTOR_DATA_RATE
	#define BILL_ACCEPTOR_DATA_RATE 300
#endif

namespace billAcceptor {
	void init();
	void loop();
	float getAccumulatedValue();
	void reset();
}

#endif
