#ifndef BLESKOMAT_CONFIG_H
#define BLESKOMAT_CONFIG_H

#include "logger.h"
#include "sdcard.h"
#include "util.h"

#include <lnurl.h>
#include <Preferences.h>

#include <algorithm>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>

struct BleskomatWifiConfig {
	std::string ssid = "";
	std::string password = "";
};

struct BleskomatConfig {
	struct LnurlSignerConfig lnurl;
	std::string uriSchemaPrefix = "LIGHTNING";
	unsigned short fiatPrecision = 2;
	double buyLimit = 0.00;
	std::vector<float> coinValues;
	std::vector<float> billValues;
	std::string instructionsUrl = "https://www.bleskomat.com/intro?id={{API_KEY_ID}}";
	struct BleskomatWifiConfig wifi;
};

namespace config {
	void init();
	LnurlSignerConfig getLnurlSignerConfig();
	BleskomatWifiConfig getWifiConfig();
	BleskomatConfig getAll();
	std::string get(const char* &t_key);
	std::string get(const std::string &key);
	unsigned short getFiatPrecision();
	double getBuyLimit();
	std::vector<float> getCoinValues();
	std::vector<float> getBillValues();
}

#endif
