#ifndef BLESKOMAT_MODULES_BILL_ACCEPTOR_H
#define BLESKOMAT_MODULES_BILL_ACCEPTOR_H

#include "config.h"
#include "logger.h"
#include "util.h"

#include <HardwareSerial.h>

#include <deque>

#ifndef BILL_ACCEPTOR_TX
	#define BILL_ACCEPTOR_TX 3
#endif

#ifndef BILL_ACCEPTOR_RX
	#define BILL_ACCEPTOR_RX 21
#endif

#ifndef BILL_ACCEPTOR_BAUDRATE
	#define BILL_ACCEPTOR_BAUDRATE 300
#endif

#ifndef BILL_ACCEPTOR_CODE_ENABLE_ALL
	#define BILL_ACCEPTOR_CODE_ENABLE_ALL 184
#endif

#ifndef BILL_ACCEPTOR_CODE_DISABLE_ALL
	#define BILL_ACCEPTOR_CODE_DISABLE_ALL 185
#endif

#ifndef BILL_ACCEPTOR_CODE_ENABLE_ESCROW
	#define BILL_ACCEPTOR_CODE_ENABLE_ESCROW 170
#endif

#ifndef BILL_ACCEPTOR_CODE_ACCEPT_ESCROW
	#define BILL_ACCEPTOR_CODE_ACCEPT_ESCROW 172
#endif

#ifndef BILL_ACCEPTOR_CODE_REJECT_ESCROW
	#define BILL_ACCEPTOR_CODE_REJECT_ESCROW 173
#endif

#ifndef BILL_ACCEPTOR_CODE_IS_BUSY
	#define BILL_ACCEPTOR_CODE_IS_BUSY 120
#endif

#ifndef BILL_ACCEPTOR_CODE_NOT_BUSY
	#define BILL_ACCEPTOR_CODE_NOT_BUSY 121
#endif

namespace billAcceptor {
	void init();
	void loop();
	float getAccumulatedValue();
	float getEscrowValue();
	void enableEscrowMode();
	void clearEscrowValue();
	void acceptEscrow();
	void rejectEscrow();
	void reset();
	void on();
	void off();
}

#endif
