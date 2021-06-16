#ifndef BLESKOMAT_NETWORK_H
#define BLESKOMAT_NETWORK_H

#include "config.h"
#include "logger.h"
#include "ping-server.h"
#include "platform.h"

#include <WiFi.h>

#include <stdexcept>
#include <string>

namespace network {
	void init();
	void loop();
	bool isConnected();
	bool platformIsDown();
	std::string getUserAgent();
}

#endif
