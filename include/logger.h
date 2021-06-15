#ifndef BLESKOMAT_LOGGER_H
#define BLESKOMAT_LOGGER_H

#include "sdcard.h"

#include <iostream>
#include <string>

namespace logger {
	void write(const std::string &t_msg, const std::string &t_type);
	void write(const std::string &t_msg);
}

#endif
