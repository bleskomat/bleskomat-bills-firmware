#ifndef BLESKOMAT_CACHE_H
#define BLESKOMAT_CACHE_H

#include <Preferences.h>
#include <string>
#include "util.h"

namespace cache {
	void init();
	void end();
	std::string getString(const char* key);
	void save(const char* key, const std::string &value);
	void cacheSplashScreen();
	void cacheInstructionsScreen();
	void cacheInsertFiatScreen(const float &accumulatedValue);
	void cacheTradeCompleteScreen(const float &accumulatedValue, const std::string &qrcodeData, const std::string &referencePhrase);
}

#endif
