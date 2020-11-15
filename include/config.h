#ifndef BLESKOMAT_CONFIG_H
#define BLESKOMAT_CONFIG_H

#include "logger.h"
#include "sdcard.h"

#include <lnurl.h>

#include <algorithm>
#include <string>
#include <fstream>
#include <sstream>

namespace config {
	void init();
	LnurlSignerConfig getConfig();
}

#endif
