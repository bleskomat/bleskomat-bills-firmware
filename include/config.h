#ifndef BLESKOMAT_CONFIG_H
#define BLESKOMAT_CONFIG_H

#include "logger.h"
#include "sdcard.h"
#include "util.h"

#include <ArduinoJson.h>
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
	std::string uriSchemaPrefix = "";// "LIGHTNING:", "lightning:", or ""
	std::string fiatCurrency = "EUR";
	unsigned short fiatPrecision = 2;
	std::string feePercent = "0.00";
	double buyLimit = 0.00;
	std::vector<float> coinValues;
	std::vector<float> billValues;
	std::string webUrl = "https://www.bleskomat.com";
	std::string platformSockUri = "wss://www.bleskomat.com/device";
	std::string pingSockUri = "wss://ping.bleskomat.com/";
	std::string referencePhrase = "";
	bool enabled = true;
	struct BleskomatWifiConfig wifi;
	std::string locale = "en";
	bool strictTls = false;
};

namespace config {
	void init();
	Lnurl::SignerConfig getLnurlSignerConfig();
	BleskomatWifiConfig getWifiConfig();
	bool strictTls();
	std::string get(const char* &t_key);
	std::string get(const std::string &key);
	unsigned short getFiatPrecision();
	double getBuyLimit();
	std::vector<float> getCoinValues();
	std::vector<float> getBillValues();
	bool isEnabled();
	JsonObject getConfigurations();
	bool saveConfigurations(const JsonObject &configurations);
}

#endif
