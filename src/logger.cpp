#include "logger.h"

namespace {

	const std::string debugLogFileName = "debug.log";

	void writeToSerialMonitor(const std::string &msg) {
		std::cout << msg << std::endl;
	}

	void writeToDebugFile(const std::string &msg) {
		sdcard::appendToFile(debugLogFileName, msg);
	}
}

namespace logger {

	void write(const std::string &t_msg, const std::string &t_type) {
		const std::string msg = "[" + t_type + "] " + t_msg;
		writeToSerialMonitor(msg);
		writeToDebugFile(msg);
	}

	void write(const std::string &t_msg) {
		write(t_msg, "info");
	}
}
