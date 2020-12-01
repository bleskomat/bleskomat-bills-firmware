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

struct BleskomatConfig {
	struct LnurlSignerConfig lnurl;
	unsigned short fiatPrecision = 2;
	double transactionLimit = 0.00;
};

namespace config {
	void init();
	LnurlSignerConfig getLnurlSignerConfig();
	BleskomatConfig getAll();
	std::string get(const char* &t_key);
	std::string get(const std::string &key);
	unsigned short getFiatPrecision();
	double getTransactionLimit();
}

#endif
