#ifndef BLESKOMAT_NETWORK_H
#define BLESKOMAT_NETWORK_H

#include "config.h"
#include "logger.h"

#include <WiFi.h>

#define FETCH_EXCHANGE_RATE

#ifdef FETCH_EXCHANGE_RATE
#include <WiFiClientSecure.h>
#include <ArduinoJson.h>
#endif

#include <string>

namespace network {
	void init();
	void loop();
	void connect();
	bool isConnected();
	void fetchExchangeRate(std::string currency);
	void printExchangeRate();
}

#endif
