#ifndef BLESKOMAT_MAIN_H
#define BLESKOMAT_MAIN_H

#include "config.h"
#include "logger.h"
#include "modules.h"
#include "network.h"
#include "util.h"

#ifdef WIFI_ACCESS_POINT
	#include "wifi-access-point.h"
#endif

#include <lnurl.h>
#include <string>

#define STRINGIFY(s) STRINGIFY1(s)
#define STRINGIFY1(s) #s

#ifndef FIRMWARE_VERSION
	#error "Missing required build flag: FIRMWARE_VERSION"
#endif

#ifndef FIRMWARE_COMMIT_HASH
	#error "Missing required build flag: FIRMWARE_COMMIT_HASH"
#endif

namespace {
	std::string trimQuotes(const std::string &str) {
		return str.substr(1, str.length() - 2);
	}
}

const std::string firmwareVersion(trimQuotes(STRINGIFY(FIRMWARE_VERSION)));
const std::string firmwareCommitHash(trimQuotes(STRINGIFY(FIRMWARE_COMMIT_HASH)));

#endif
