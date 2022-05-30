#ifndef BLESKOMAT_PLATFORM_H
#define BLESKOMAT_PLATFORM_H

#include "config.h"
#include "logger.h"
#include "network.h"
#include "spiffs.h"

#include <ArduinoJson.h>
#include "esp_websocket_client.h"

#include <stdexcept>
#include <string>
#include <vector>

namespace platform {
	void init();
	void loop();
	bool isConfigured();
	bool isConnected();
	float getExchangeRate();
}

#endif
