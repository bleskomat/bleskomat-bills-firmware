#ifndef BLESKOMAT_UTIL_H
#define BLESKOMAT_UTIL_H

#include "config.h"

#include <Arduino.h>
#include <lnurl.h>

#include <chrono>
#include <sstream>

namespace util {

	std::string createSignedWithdrawRequest(const double &accumulatedValue);
	std::string toUpperCase(std::string s);
}

#endif
