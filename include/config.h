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

struct BleskomatConfig {
	struct LnurlSignerConfig lnurl;
	unsigned short fiatPrecision = 2;
	double transactionLimit = 0.00;
	std::vector<float> coinValues;
	std::vector<float> billValues;
	std::string instructionsUrl = "https://www.bleskomat.com/intro?id={{API_KEY_ID}}";
};

namespace config {
	void init();
	LnurlSignerConfig getLnurlSignerConfig();
	BleskomatConfig getAll();
	std::string get(const char* &t_key);
	std::string get(const std::string &key);
	unsigned short getFiatPrecision();
	double getTransactionLimit();
	std::vector<float> getCoinValues();
	std::vector<float> getBillValues();
}

#endif
