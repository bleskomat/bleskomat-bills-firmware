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

	std::string createSignedWithdrawUrl(const double &accumulatedValue, const std::string &referenceCode = "");
	std::string lnurlEncode(const std::string &text);
	std::string generateRandomWords(const unsigned int numWords = 3);
	std::string toUpperCase(std::string s);
	std::vector<std::string> stringListToStringVector(const std::string &stringList, const char &delimiter = ',');
	std::vector<float> stringListToFloatVector(const std::string &stringList, const char &delimiter = ',');
	std::string floatVectorToStringList(const std::vector<float> floatVector, const char &delimiter = ',');
	std::string replaceFirstOccurrence(
		std::string& s,
		const std::string& toReplace,
		const std::string& replaceWith
	);
	std::string urlEncode(const std::string &value);
}

#endif
