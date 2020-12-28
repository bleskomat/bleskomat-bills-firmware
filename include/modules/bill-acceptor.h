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

#ifndef BILL_ACCEPTOR_CODE_ENABLE_ALL
	#define BILL_ACCEPTOR_CODE_ENABLE_ALL 184
#endif

#ifndef BILL_ACCEPTOR_CODE_DISABLE_ALL
	#define BILL_ACCEPTOR_CODE_DISABLE_ALL 185
#endif

namespace billAcceptor {
	void init();
	void loop();
	float getAccumulatedValue();
	void reset();
	void on();
	void off();
}

#endif
