#include "logger.h"
#include <Arduino.h>

#ifndef COIN_ACCEPTOR_PIN
	#define COIN_ACCEPTOR_PIN 4
#endif

#ifndef COIN_RELAY_PIN
	#define COIN_RELAY_PIN 2
#endif

namespace coinAcceptor {
	void init();
	void loop();
	bool coinInserted();
	float getAccumulatedValue();
	void setFiatCurrency(const std::string &fiatCurrency);
	void reset();
	void on();
	void off();
}
