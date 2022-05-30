#ifndef BLESKOMAT_NETWORK_H
#define BLESKOMAT_NETWORK_H

#include "config.h"
#include "logger.h"
#include "main.h"
#include "platform.h"

#include <WiFi.h>

#include <stdexcept>
#include <string>

namespace network {
	void init();
	void loop();
	bool isConnected();
	std::string getUserAgent();
}

#endif
