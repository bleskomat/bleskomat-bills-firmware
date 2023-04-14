#include "cache.h"

namespace {

	// Using Preferences library as a wrapper to Non-Volatile Storage (flash memory):
	// https://github.com/espressif/arduino-esp32/tree/master/libraries/Preferences
	// https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/storage/nvs_flash.html
	const char* nvs_namespace = "BleskomatCache";
	const bool nvs_readonly = false;
	Preferences nvs_prefs;
	bool nvs_available = false;

	bool initNVS() {
		const bool result = nvs_prefs.begin(nvs_namespace, nvs_readonly);
		if (result) {
			nvs_available = true;
		}
		return result;
	}

	void endNVS() {
		nvs_prefs.end();
		nvs_available = false;
	}

	// Maximum NVS key length is 15 characters.
	const unsigned short nvsKeyMaxLength = 15;

	std::string truncateNVSKey(const char* key) {
		return std::string(key).substr(0, nvsKeyMaxLength);
	}

	bool keyExistsInNVS(const char* t_key) {
		const std::string key = truncateNVSKey(t_key);
		return nvs_prefs.isKey(key.c_str());
	}

	std::string readValueFromNVS(const char* t_key) {
		if (!keyExistsInNVS(t_key)) {
			return "";
		}
		const std::string key = truncateNVSKey(t_key);
		return std::string(nvs_prefs.getString(key.c_str(), "").c_str());
	}

	void saveKeyValueToNVS(const char* t_key, const std::string &value) {
		if (!keyExistsInNVS(t_key) || readValueFromNVS(t_key) != value) {
			const std::string key = truncateNVSKey(t_key);
			nvs_prefs.putString(key.c_str(), value.c_str());
		}
	}

	void removeKeyValueFromNVS(const char* t_key) {
		if (keyExistsInNVS(t_key)) {
			const std::string key = truncateNVSKey(t_key);
			nvs_prefs.remove(key.c_str());
		}
	}
}

namespace cache {

	std::string getString(const char* key) {
		if (nvs_available || initNVS()) {
			const std::string value = readValueFromNVS(key);
			endNVS();
			return value;
		}
		return "";
	}

	void save(const char* key, const std::string &value) {
		if (nvs_available || initNVS()) {
			saveKeyValueToNVS(key, value);
			endNVS();
		}
	}

	void save(
		const char* key1, const std::string &value1,
		const char* key2, const std::string &value2
	) {
		if (nvs_available || initNVS()) {
			saveKeyValueToNVS(key1, value1);
			saveKeyValueToNVS(key2, value2);
			endNVS();
		}
	}

	void save(
		const char* key1, const std::string &value1,
		const char* key2, const std::string &value2,
		const char* key3, const std::string &value3
	) {
		if (nvs_available || initNVS()) {
			saveKeyValueToNVS(key1, value1);
			saveKeyValueToNVS(key2, value2);
			saveKeyValueToNVS(key3, value3);
			endNVS();
		}
	}

	void remove(const char* key) {
		if (nvs_available || initNVS()) {
			removeKeyValueFromNVS(key);
			endNVS();
		}
	}

	void remove(const char* key1, const char* key2) {
		if (nvs_available || initNVS()) {
			removeKeyValueFromNVS(key1);
			removeKeyValueFromNVS(key2);
			endNVS();
		}
	}
}
