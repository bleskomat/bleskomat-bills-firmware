#ifndef BLESKOMAT_SDCARD_H
#define BLESKOMAT_SDCARD_H

#include <deque>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string.h>
#include <sys/unistd.h>
#include <sys/stat.h>

#include <Arduino.h>
#include "esp_err.h"
#include "esp_log.h"
#include "esp_vfs_fat.h"
#include "ff.h"
#include "driver/sdmmc_host.h"
#include "driver/sdspi_host.h"
#include "sdmmc_cmd.h"

namespace sdcard {
	void init();
	void loop();
	bool isMounted();
	void mount();
	void unmount();
	std::string getMountedPath(const char* partialPath);
	void appendToFile(const char* filePath, const std::string &text);
	std::string readFile(const char* filePath);
	bool fileExists(const char* filePath);
}

#endif
