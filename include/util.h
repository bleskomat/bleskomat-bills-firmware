#ifndef BLESKOMAT_UTIL_H
#define BLESKOMAT_UTIL_H

#include "config.h"

#include <Arduino.h>
#include <lnurl.h>

#include <chrono>
#include <sstream>

namespace util {

	std::string createSignedWithdrawUrl(const double &accumulatedValue);
	std::string lnurlEncode(const std::string &text);
	std::string toUpperCase(std::string s);
	std::string doubleToString(const double &number);
	std::string unsignedIntToString(const unsigned int &number);
	std::string byteToString(const byte &byteIn);
}

#endif
