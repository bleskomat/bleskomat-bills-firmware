#ifndef BLESKOMAT_SDCARD_H
#define BLESKOMAT_SDCARD_H

#include "logger.h"

#include <stdio.h>
#include <string.h>
#include <sys/unistd.h>
#include <sys/stat.h>

#include "esp_err.h"
#include "esp_log.h"
#include "esp_vfs_fat.h"
#include "driver/sdmmc_host.h"
#include "driver/sdspi_host.h"
#include "sdmmc_cmd.h"

namespace sdcard {
	bool isMounted();
	std::string getMountPoint();
	void init();
}

#endif
