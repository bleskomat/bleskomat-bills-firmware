#ifndef BLESKOMAT_PLATFORM_H
#define BLESKOMAT_PLATFORM_H

#include "config.h"
#include "logger.h"
#include "network.h"

#include <ArduinoJson.h>
#include "esp_websocket_client.h"

#include <stdexcept>
#include <string>

namespace platform {
	void loop();
	bool isConfigured();
	bool isConnected();
	double getExchangeRate();
}

#endif
