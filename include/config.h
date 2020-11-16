#ifndef BLESKOMAT_CONFIG_H
#define BLESKOMAT_CONFIG_H

#include "logger.h"
#include "sdcard.h"

#include <lnurl.h>
#include <Preferences.h>

#include <algorithm>
#include <string>
#include <fstream>
#include <sstream>

namespace config {
	void init();
	LnurlSignerConfig getAll();
	std::string get(const char* t_key);
	std::string get(const std::string &key);
}

#endif
