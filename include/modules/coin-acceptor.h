#include "logger.h"
#include <Arduino.h>

#ifndef COIN_ACCEPTOR_PIN
	#define COIN_ACCEPTOR_PIN 4
#endif

namespace coinAcceptor {
	void init();
	void loop();
	bool coinInserted();
	unsigned long getTimeSinceLastCoinInserted();
	float getAccumulatedValue();
	void setFiatCurrency(const std::string &fiatCurrency);
	void reset();
}
