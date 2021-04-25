#ifndef BLESKOMAT_WIFI_ACCESS_POINT_H
#define BLESKOMAT_WIFI_ACCESS_POINT_H

#include "config.h"
#include "logger.h"
#include "util.h"

#include <DNSServer.h>
#include <esp_wifi.h>
#include <WebServer.h>
#include <WiFi.h>
#include <WiFiAP.h>

#include <map>
#include <sstream>
#include <string>

namespace wifiAccessPoint {
	void loop();
	void start();
	void stop();
	bool isAvailable();
	unsigned long getTimeAvailable();
	bool hasClientsConnected();
	std::string getSSID();
	std::string getPassword();
	std::string getConfigurationString();
	std::string getURL();
}

#endif
