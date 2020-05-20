#include "logger.h"

namespace {
	bool ENABLED = false;
}

namespace logger {

	void enable() {
		ENABLED = true;
	}

	void write(const std::string &msg) {
		if (ENABLED) {
			std::cout << msg << '\n';
		}
	}
}
