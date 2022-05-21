#ifndef BLESKOMAT_UTIL_H
#define BLESKOMAT_UTIL_H

#include "config.h"
#include "bip39-wordlist/en.h"

#include <Arduino.h>
#include <lnurl.h>

#include <chrono>
#include <cmath>
#include <sstream>
#include <string>
#include <vector>

namespace util {

	std::string createSignature(const std::string &payload);
	std::string createSignedUrl(const std::string t_baseUrl, const Lnurl::Query &t_query);
	std::string createSignedLnurlWithdraw(const float &amount, const Lnurl::Query &customParams);
	std::string lnurlEncode(const std::string &text);
	std::string generateRandomPhrase(const unsigned int numWords = 3, const std::string delimiter = " ");
	std::string toUpperCase(std::string s);
	std::vector<std::string> stringListToStringVector(const std::string &stringList, const char &delimiter = ',');
	std::vector<float> stringListToFloatVector(const std::string &stringList, const char &delimiter = ',');
	std::string floatVectorToStringList(const std::vector<float> floatVector, const char &delimiter = ',');
	float findMaxValueInFloatVector(const std::vector<float> &floatVector);
	std::string urlEncode(const std::string &value);
	std::string floatToStringWithPrecision(const float &value, const unsigned short &precision = 6);
}

#endif
