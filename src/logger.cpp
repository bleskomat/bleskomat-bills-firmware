#include "logger.h"

namespace {

	const char* debugLogFileName = "debug.log";

	void writeToSerialMonitor(const std::string &msg) {
		std::cout << msg << std::endl;
	}

	void writeToDebugFile(const std::string &msg) {
		sdcard::appendToFile(debugLogFileName, msg);
	}
}

namespace logger {

	void write(const std::string &msg, const std::string &type) {
		logger::write(msg.c_str(), type.c_str());
	}

	void write(const std::string &msg, const char* type) {
		logger::write(msg.c_str(), type);
	}

	void write(const std::string &msg) {
		logger::write(msg.c_str());
	}

	void write(const char* msg) {
		write(msg, "info");
	}

	void write(const char* t_msg, const char* type) {
		const std::string msg = "[" + std::string(type) + "] " + std::string(t_msg);
		writeToSerialMonitor(msg);
		writeToDebugFile(msg);
	}
}
