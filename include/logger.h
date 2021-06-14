#ifndef BLESKOMAT_LOGGER_H
#define BLESKOMAT_LOGGER_H

#include "ff.h"

#include <fstream>
#include <iostream>
#include <string>

namespace logger {
	void init(const std::string &t_sdCardMountPath);
	void write(const std::string &t_msg, const std::string &t_type);
	void write(const std::string &t_msg);
}

#endif
