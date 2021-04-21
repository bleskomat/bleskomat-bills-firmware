#ifndef BLESKOMAT_NETWORK_H
#define BLESKOMAT_NETWORK_H

#include "config.h"
#include "logger.h"

#include <WiFi.h>

#include <WiFiClientSecure.h>
#include <ArduinoJson.h>

#include <string>

namespace network {
	void init();
	void loop();
	void connect();
	bool isConnected();
	void fetchExchangeRate(std::string currency);
	double getExchangeRate();
}

#endif
