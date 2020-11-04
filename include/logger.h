#ifndef BLESKOMAT_LOGGER_H
#define BLESKOMAT_LOGGER_H

#include <iostream>
#include <string>

namespace logger {
	void enable();
	void write(const std::string &msg);
}

#endif
