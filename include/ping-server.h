#ifndef BLESKOMAT_PING_SERVER_H
#define BLESKOMAT_PING_SERVER_H

#include "config.h"
#include "logger.h"
#include "network.h"

#include "esp_websocket_client.h"

#include <stdexcept>
#include <string>

namespace pingServer {
	void loop();
	bool isConfigured();
	bool isConnected();
}

#endif
