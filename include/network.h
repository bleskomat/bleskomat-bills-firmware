#ifndef BLESKOMAT_NETWORK_H
#define BLESKOMAT_NETWORK_H

#include "config.h"
#include "logger.h"

#include <WiFi.h>
#include <WiFiClientSecure.h>

#include <map>
#include <sstream>
#include <string>

namespace network {
	void init();
	void loop();
	void connect();
	bool isConnected();
}

#endif
