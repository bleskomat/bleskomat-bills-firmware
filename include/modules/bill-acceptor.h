#ifndef BLESKOMAT_MODULES_BILL_ACCEPTOR_H
#define BLESKOMAT_MODULES_BILL_ACCEPTOR_H

#include "logger.h"
#include "util.h"

#include <Arduino.h>
#include <SoftwareSerial.h>

#include <map>

#ifndef BILL_ACCEPTOR_RX_PIN
	#define BILL_ACCEPTOR_RX_PIN 3
#endif

#ifndef BILL_ACCEPTOR_TX_PIN
	#define BILL_ACCEPTOR_TX_PIN 1
#endif

#ifndef BILL_ACCEPTOR_DATA_RATE
	#define BILL_ACCEPTOR_DATA_RATE 300
#endif

namespace billAcceptor {
	void init();
	void loop();
	bool billInserted();
	unsigned int getAccumulatedValue();
	void setFiatCurrency(const std::string &fiatCurrency);
	void reset();
}

#endif
