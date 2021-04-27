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
	struct Lnurl::SignerConfig lnurl;
	std::string uriSchemaPrefix = "LIGHTNING";
	std::string fiatCurrency = "EUR";
	unsigned short fiatPrecision = 2;
	double exchangeRate = 0.00;
	double buyLimit = 0.00;
	std::vector<float> coinValues;
	std::vector<float> billValues;
	std::string statusUrl = "https://www.bleskomat.com/api/v1/status";
	std::string instructionsUrl = "https://www.bleskomat.com/intro?id={{API_KEY_ID}}";
	std::string referencePhrase = "";
	bool enabled = true;
	struct BleskomatWifiConfig wifi;
};

namespace config {
	void init();
	Lnurl::SignerConfig getLnurlSignerConfig();
	BleskomatWifiConfig getWifiConfig();
	BleskomatConfig getAll();
	std::string get(const char* &t_key);
	std::string get(const std::string &key);
	unsigned short getFiatPrecision();
	double getExchangeRate();
	double getBuyLimit();
	std::vector<float> getCoinValues();
	std::vector<float> getBillValues();
	bool isEnabled();
}

#endif
