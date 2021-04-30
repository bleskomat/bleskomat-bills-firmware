#ifndef BLESKOMAT_NETWORK_H
#define BLESKOMAT_NETWORK_H

#include "config.h"
#include "logger.h"

#include <ArduinoJson.h>
#include <WiFi.h>
#include "esp_websocket_client.h"

#include <map>
#include <stdexcept>
#include <string>

namespace network {
	void init();
	void loop();
	void connect();
	bool isConnected();
	bool isConnectedToWebServer();
	double getExchangeRate();
}

#endif
