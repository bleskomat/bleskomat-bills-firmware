#include "logger.h"

// See:
// https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/storage/fatfs.html
// http://elm-chan.org/fsw/ff/00index_e.html

namespace {

	std::string sdCardMountPath = "";
	std::string logsDirPath = "/logs";
	std::string debugFileName = "debug.log";
	FRESULT lastFileOpResult;
	bool logsDirExists = false;

	// For full list of result codes (and their detailed meanings):
	// http://elm-chan.org/fsw/ff/doc/rc.html
	std::string getFileOpResultDebugMessage(FRESULT &result) {
		if (result == FR_OK) {
			return "FR_OK";
		} else if (result == FR_DISK_ERR) {
			return "FR_DISK_ERR";
		} else if (result == FR_INT_ERR) {
			return "FR_INT_ERR";
		} else if (result == FR_NOT_READY) {
			return "FR_NOT_READY";
		} else if (result == FR_NO_PATH) {
			return "FR_NO_PATH";
		} else if (result == FR_INVALID_NAME) {
			return "FR_INVALID_NAME";
		} else if (result == FR_DENIED) {
			return "FR_DENIED";
		} else if (result == FR_EXIST) {
			return "FR_EXIST";
		} else if (result == FR_WRITE_PROTECTED) {
			return "FR_WRITE_PROTECTED";
		} else if (result == FR_INVALID_DRIVE) {
			return "FR_INVALID_DRIVE";
		} else if (result == FR_NOT_ENABLED) {
			return "FR_NOT_ENABLED";
		} else if (result == FR_NO_FILESYSTEM) {
			return "FR_NO_FILESYSTEM";
		} else if (result == FR_TIMEOUT) {
			return "FR_TIMEOUT";
		} else if (result == FR_NOT_ENOUGH_CORE) {
			return "FR_NOT_ENOUGH_CORE";
		}
		return "UNKOWN";
	}

	std::string getLogsDirectoryPath(bool withSDCardMountPath = true) {
		std::string dirPath = "";
		if (withSDCardMountPath) {
			dirPath += sdCardMountPath;
		}
		dirPath += logsDirPath;
		return dirPath;
	}

	bool logsDirectoryExists() {
		const std::string dirPath = getLogsDirectoryPath(false);
		// http://elm-chan.org/fsw/ff/doc/stat.html
		return f_stat(dirPath.c_str(), NULL) == FR_OK;
	}

	bool createLogsDirectory() {
		const std::string dirPath = getLogsDirectoryPath(false);
		// http://elm-chan.org/fsw/ff/doc/mkdir.html
		lastFileOpResult = f_mkdir(dirPath.c_str());
		return lastFileOpResult == FR_OK;
	}

	std::string getDebugFilePath() {
		return getLogsDirectoryPath(true) + "/" + debugFileName;
	}

	bool writeToSerialMonitor(const std::string &msg) {
		std::cout << msg << std::endl;
		return true;
	}

	bool writeToDebugFile(const std::string &msg) {
		if (!logsDirExists) return false;
		const std::string filePath = getDebugFilePath();
		std::ofstream file;
		// Open file for writing (append mode).
		file.open(filePath.c_str(), std::ios::app);
		file << msg << std::endl;
		file.close();
		return true;
	}
}

namespace logger {

	void init(const std::string &t_sdCardMountPath) {
		sdCardMountPath= t_sdCardMountPath;
		if (!logsDirectoryExists()) {
			if (createLogsDirectory()) {
				write("Logs directory created " + logsDirPath);
				logsDirExists = true;
			} else {
				write("Failed to create logs directory " + logsDirPath + " " + getFileOpResultDebugMessage(lastFileOpResult));
			}
		} else {
			logsDirExists = true;
		}
		write("Logger initialized");
	}

	void write(const std::string &t_msg, const std::string &t_type) {
		const std::string msg = "[" + t_type + "] " + t_msg;
		writeToSerialMonitor(msg);
		writeToDebugFile(msg);
	}

	void write(const std::string &t_msg) {
		return write(t_msg, "info");
	}

	void logTransaction(const std::string &signedUrl) {
		std::string msg = "New signed LNURL generated -> ";
		msg += signedUrl;
		return write(msg, "transaction");
	}
}
