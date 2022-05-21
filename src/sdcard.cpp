#include "sdcard.h"

// See:
// https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/storage/fatfs.html
// http://elm-chan.org/fsw/ff/00index_e.html

namespace {

	const char* mountpoint = "/sdcard";
	bool mounted = false;
	int numMountFailures = 0;
	const int maxMountAttempts = 3;
	unsigned long lastMountFailureTime = 0;
	const unsigned long mountAttemptWaitTime = 2000;
	typedef std::pair< const char*, std::string > AppendToFileBufferItem;
	std::deque<AppendToFileBufferItem> appendToFileBuffer;

	void doAppendToFile(const char* t_filePath, const std::string &text) {
		std::ofstream file;
		const std::string filePath = sdcard::getMountedPath(t_filePath);
		// Open file for writing (append mode):
		file.open(filePath.c_str(), std::ios::app);
		file << text << std::endl;
		file.close();
	}

	void handleAppendToFileBuffer() {
		while (appendToFileBuffer.size() > 0) {
			const AppendToFileBufferItem item = appendToFileBuffer.front();
			appendToFileBuffer.pop_front();
			doAppendToFile(item.first, item.second);
		}
	}

	void handleBuffers() {
		handleAppendToFileBuffer();
	}
}

namespace sdcard {

	void init() {
		mount();
		if (mounted) {
			std::cout << "SD card mounted" << std::endl;
		}
	}

	void loop() {
		if (mounted) {
			handleBuffers();
		} else if (
			lastMountFailureTime == 0 || (
				numMountFailures < maxMountAttempts &&
				millis() - lastMountFailureTime > mountAttemptWaitTime
			)
		) {
			mount();
		}
	}

	bool isMounted() {
		return mounted;
	}

	void mount() {
		if (!mounted) {
			// https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/sdspi_host.html
			sdmmc_host_t host = SDSPI_HOST_DEFAULT();
			sdspi_slot_config_t slot_config = SDSPI_SLOT_CONFIG_DEFAULT();
			slot_config.gpio_miso = (gpio_num_t) SD_MISO;
			slot_config.gpio_mosi = (gpio_num_t) SD_MOSI;
			slot_config.gpio_sck  = (gpio_num_t) SD_SCK;
			slot_config.gpio_cs   = (gpio_num_t) SD_CS;
			// Options for mounting the filesystem.
			// If format_if_mount_failed is set to true, SD card will be partitioned and
			// formatted in case when mounting fails.
			esp_vfs_fat_sdmmc_mount_config_t mount_config =
				{
					.format_if_mount_failed = false,
					.max_files = 5,
					.allocation_unit_size = 16 * 1024
				};
			// Use settings defined above to initialize SD card and mount FAT filesystem.
			// Note: esp_vfs_fat_sdmmc_mount is an all-in-one convenience function.
			// Please check its source code and implement error recovery when developing
			// production applications.
			sdmmc_card_t* card;
			esp_err_t result = esp_vfs_fat_sdmmc_mount(mountpoint, &host, &slot_config, &mount_config, &card);
			if (result != ESP_OK) {
				if (result == ESP_FAIL) {
					std::cout << "Failed to mount SD card: ESP_FAIL (Partition cannot be mounted)" << std::endl;
				} else {
					std::cout << "Failed to mount SD card: " + std::string(esp_err_to_name(result)) << std::endl;
				}
				numMountFailures++;
				lastMountFailureTime = millis();
			} else {
				// Card has been initialized, print its properties.
				sdmmc_card_print_info(stdout, card);
				mounted = true;
				numMountFailures = 0;
				lastMountFailureTime = 0;
			}
		}
	}

	void unmount() {
		if (mounted) {
			// Unmount partition and disable SDMMC or SPI peripheral
			esp_vfs_fat_sdmmc_unmount();
			mounted = false;
			numMountFailures = 0;
			lastMountFailureTime = 0;
		}
	}

	std::string getMountedPath(const char* partialPath) {
		return std::string(mountpoint) + "/" + std::string(partialPath);
	}

	void appendToFile(const char* filePath, const std::string &text) {
		AppendToFileBufferItem item;
		item.first = filePath;
		item.second = text;
		appendToFileBuffer.push_back(item);
	}

	std::string readFile(const char* t_filePath) {
		std::ostringstream buffer;
		std::ifstream file;
		const std::string filePath = sdcard::getMountedPath(t_filePath);
		// Open file for reading:
		file.open(filePath.c_str(), std::ios::in);
		std::string line;
		while (std::getline(file, line)) {
			buffer << line;
			if (file.eof()) {
				break;
			} else {
				buffer << "\n";
			}
		}
		file.close();
		return buffer.str();
	}

	bool fileExists(const char* filePath) {
		// http://elm-chan.org/fsw/ff/doc/stat.html
		return f_stat(filePath, NULL) == FR_OK;
	}
}
