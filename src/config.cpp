#include "config.h"

namespace {

	// The configuration object:
	BleskomatConfig values;

	const std::string configFileName = "bleskomat.conf";

	// List of configuration keys:
	const std::vector<std::string> configKeys = {
		"apiKey.id",
		"apiKey.key",
		"apiKey.encoding",
		"callbackUrl",
		"shorten",
		"uriSchemaPrefix",
		"fiatCurrency",
		"fiatPrecision",
		"feePercent",
		"exchangeRate",
		"buyLimit",
		"coinValues",
		"billValues",
		"webUrl",
		"webCACert",
		"referencePhrase",
		"enabled",
		"wifi.ssid",
		"wifi.password"
	};

	// Subset of configuration keys that we allow to be saved.
	const std::vector<std::string> allowSaveConfigKeys = {
		"fiatCurrency",
		"fiatPrecision",
		"feePercent",
		"exchangeRate",
		"buyLimit",
		"referencePhrase",
		"enabled"
	};

	// Using Preferences library as a wrapper to Non-Volatile Storage (flash memory):
	// https://github.com/espressif/arduino-esp32/tree/master/libraries/Preferences
	// https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/storage/nvs_flash.html
	BleskomatConfig nvs_values;
	const std::string nvs_namespace = "BleskomatConfig";
	const bool nvs_readonly = false;
	Preferences nvs_prefs;
	bool nvs_available = false;

	bool setConfigValue(const std::string &key, const std::string &value, BleskomatConfig &t_values) {
		if (key == "apiKey.id") {
			t_values.lnurl.apiKey.id = value;
		} else if (key == "apiKey.key") {
			t_values.lnurl.apiKey.key = value;
		} else if (key == "apiKey.encoding") {
			t_values.lnurl.apiKey.encoding = value;
		} else if (key == "callbackUrl") {
			t_values.lnurl.callbackUrl = value;
		} else if (key == "shorten") {
			t_values.lnurl.shorten = (value == "true" || value == "1");
		} else if (key == "uriSchemaPrefix") {
			t_values.uriSchemaPrefix = value;
		} else if (key == "fiatCurrency") {
			t_values.fiatCurrency = value;
		} else if (key == "feePercent") {
			t_values.feePercent = value;
		} else if (key == "exchangeRate") {
			// Convert string to double:
			t_values.exchangeRate = std::strtod(value.c_str(), NULL);
		} else if (key == "buyLimit") {
			// Convert string to double:
			t_values.buyLimit = std::strtod(value.c_str(), NULL);
		} else if (key == "coinValues") {
			t_values.coinValues = util::stringListToFloatVector(value);
		} else if (key == "billValues") {
			t_values.billValues = util::stringListToFloatVector(value);
		} else if (key == "fiatPrecision") {
			// Convert string to short:
			t_values.fiatPrecision = (char)( *value.c_str() - '0' );
		} else if (key == "webUrl") {
			t_values.webUrl = value;
		} else if (key == "webCACert") {
			t_values.webCACert = value;
		} else if (key == "referencePhrase") {
			t_values.referencePhrase = value;
		} else if (key == "enabled") {
			t_values.enabled = (value == "true" || value == "1");
		} else if (key == "wifi.ssid") {
			t_values.wifi.ssid = value;
		} else if (key == "wifi.password") {
			t_values.wifi.password = value;
		} else {
			return false;
		}
		return true;
	}

	std::string getConfigValue(const std::string &key, const BleskomatConfig &t_values) {
		if (key == "apiKey.id") {
			return t_values.lnurl.apiKey.id;
		} else if (key == "apiKey.key") {
			return t_values.lnurl.apiKey.key;
		} else if (key == "apiKey.encoding") {
			return t_values.lnurl.apiKey.encoding;
		} else if (key == "callbackUrl") {
			return t_values.lnurl.callbackUrl;
		} else if (key == "shorten") {
			return t_values.lnurl.shorten ? "true" : "false";
		} else if (key == "uriSchemaPrefix") {
			return t_values.uriSchemaPrefix;
		} else if (key == "fiatCurrency") {
			return t_values.fiatCurrency;
		} else if (key == "feePercent") {
			return t_values.feePercent;
		} else if (key == "exchangeRate") {
			return std::to_string(t_values.exchangeRate);
		} else if (key == "buyLimit") {
			return std::to_string(t_values.buyLimit);
		} else if (key == "coinValues") {
			return util::floatVectorToStringList(t_values.coinValues);
		} else if (key == "billValues") {
			return util::floatVectorToStringList(t_values.billValues);
		} else if (key == "fiatPrecision") {
			return std::to_string(t_values.fiatPrecision);
		} else if (key == "webUrl") {
			return t_values.webUrl;
		} else if (key == "webCACert") {
			return t_values.webCACert;
		} else if (key == "referencePhrase") {
			return t_values.referencePhrase;
		} else if (key == "enabled") {
			return t_values.enabled ? "true" : "false";
		} else if (key == "wifi.ssid") {
			return t_values.wifi.ssid;
		} else if (key == "wifi.password") {
			return t_values.wifi.password;
		}
		return "";
	}

	bool readFromConfigLine(const std::string &line, BleskomatConfig &t_values) {
		// The character used to separate key/value pair - e.g "key=value".
		const std::string delimiter = "=";
		const auto pos = line.find(delimiter);
		if (pos != std::string::npos) {
			// Found delimiter.
			const std::string key = line.substr(0, pos);
			const std::string value = line.substr(pos + 1);
			if (setConfigValue(key, value, t_values)) {
				return true;
			} else {
				logger::write("Unknown key found in configuration file: \"" + key + "\"");
			}
		}
		return false;
	}

	std::string getConfigFilePath() {
		std::string configFilePath = sdcard::getMountPoint();
		configFilePath += "/" + configFileName;
		return configFilePath;
	}

	bool readFromConfigFile() {
		try {
			const std::string filePath = getConfigFilePath();
			// Open the config file for reading.
			std::ifstream file(filePath);
			if (!file) {
				logger::write("Failed to open configuration file " + filePath);
				return false;
			}
			std::string line = "";
			while (std::getline(file, line)) {
				readFromConfigLine(line, values);
			}
			file.close();
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
			return false;
		}
		return true;
	}

	bool deleteConfigFile() {
		const std::string filePath = getConfigFilePath();
		return std::remove(filePath.c_str()) == 0;
	}

	bool initNVS() {
		const char* name = nvs_namespace.c_str();
		const bool result = nvs_prefs.begin(name, nvs_readonly);
		if (result) {
			nvs_available = true;
		}
		return result;
	}

	bool readKeyValueFromNVS(const std::string &key) {
		const std::string value = nvs_prefs.getString(key.c_str(), "").c_str();
		if (value == "") return false;
		return setConfigValue(key, value, nvs_values) && setConfigValue(key, value, values);
	}

	bool readFromNVS() {
		if (!nvs_available) {
			if (!initNVS()) {
				return false;
			}
		}
		for (int index = 0; index < configKeys.size(); index++) {
			const std::string key = configKeys[index];
			readKeyValueFromNVS(key);
		}
		return true;
	}

	bool saveKeyValueToNVS(const std::string &key, const std::string &value) {
		return nvs_prefs.putString(key.c_str(), value.c_str()) != 0;
	}

	bool saveConfigurationsToNVS(const BleskomatConfig &t_values) {
		if (!nvs_available) {
			if (!initNVS()) {
				return false;
			}
		}
		for (int index = 0; index < configKeys.size(); index++) {
			const std::string key = configKeys[index];
			const std::string value = getConfigValue(key, t_values);
			if (value != getConfigValue(key, nvs_values)) {
				// Configuration has been changed.
				// Save the new value to non-volatile storage.
				if (!saveKeyValueToNVS(key, value)) {
					logger::write("Failed to save configuration to non-volatile storage ( " + key + "=" + value + " )");
				}
			}
		}
		return true;
	}

	void endNVS() {
		nvs_prefs.end();
		nvs_available = false;
	}

	void printConfig(const BleskomatConfig &t_values) {
		std::string msg = "Printing Bleskomat configurations:\n";
		for (int index = 0; index < configKeys.size(); index++) {
			const std::string key = configKeys[index];
			const std::string value = getConfigValue(key, t_values);
			msg += "  " + key + "=" + value + "\n";
		}
		msg.pop_back();// Remove the last line-break character.
		logger::write(msg);
	}
}

namespace config {

	void init() {
		if (initNVS()) {
			logger::write("Non-volatile storage initialized");
			if (!readFromNVS()) {
				logger::write("Failed to read configurations from non-volatile storage");
			}
		} else {
			logger::write("Failed to initialize non-volatile storage");
		}
		if (sdcard::isMounted()) {
			if (readFromConfigFile()) {
				if (saveConfigurationsToNVS(values)) {
					if (deleteConfigFile()) {
						logger::write("Deleted configuration file");
					} else {
						logger::write("Failed to delete configuration file");
					}
				} else {
					logger::write("Failed to save configurations to non-volatile storage");
				}
			} else {
				logger::write("Failed to read configurations from file");
			}
		}
		endNVS();
		// Hard-coded configuration overrides - for development purposes.
		// Uncomment the following lines, as needed, to override config options.
		// values.lnurl.apiKey.id = "";
		// values.lnurl.apiKey.key = "";
		// values.lnurl.apiKey.encoding = "";
		// values.lnurl.callbackUrl = "https://ln.bleskomat.com/u";
		// values.lnurl.shorten = true;
		// values.uriSchemaPrefix = "LIGHTNING:";
		// values.fiatCurrency = "EUR";
		// values.fiatPrecision = 2;
		// values.feePercent = "0.00";
		// values.exchangeRate = 0.00;
		// values.buyLimit = 100.00;
		// values.coinValues = { 0.05, 0.10, 0.20, 0.50, 1.00, 2.00 };
		// values.billValues = { 5, 10, 20, 50, 100, 200 };
		// values.webUrl = "https://www.bleskomat.com";
		// values.webCACert = "-----BEGIN CERTIFICATE-----\nMIIEZTCCA02gAwIBAgIQQAF1BIMUpMghjISpDBbN3zANBgkqhkiG9w0BAQsFADA/\nMSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT\nDkRTVCBSb290IENBIFgzMB4XDTIwMTAwNzE5MjE0MFoXDTIxMDkyOTE5MjE0MFow\nMjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxCzAJBgNVBAMT\nAlIzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuwIVKMz2oJTTDxLs\njVWSw/iC8ZmmekKIp10mqrUrucVMsa+Oa/l1yKPXD0eUFFU1V4yeqKI5GfWCPEKp\nTm71O8Mu243AsFzzWTjn7c9p8FoLG77AlCQlh/o3cbMT5xys4Zvv2+Q7RVJFlqnB\nU840yFLuta7tj95gcOKlVKu2bQ6XpUA0ayvTvGbrZjR8+muLj1cpmfgwF126cm/7\ngcWt0oZYPRfH5wm78Sv3htzB2nFd1EbjzK0lwYi8YGd1ZrPxGPeiXOZT/zqItkel\n/xMY6pgJdz+dU/nPAeX1pnAXFK9jpP+Zs5Od3FOnBv5IhR2haa4ldbsTzFID9e1R\noYvbFQIDAQABo4IBaDCCAWQwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8E\nBAMCAYYwSwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vYXBwcy5p\nZGVudHJ1c3QuY29tL3Jvb3RzL2RzdHJvb3RjYXgzLnA3YzAfBgNVHSMEGDAWgBTE\np7Gkeyxx+tvhS5B1/8QVYIWJEDBUBgNVHSAETTBLMAgGBmeBDAECATA/BgsrBgEE\nAYLfEwEBATAwMC4GCCsGAQUFBwIBFiJodHRwOi8vY3BzLnJvb3QteDEubGV0c2Vu\nY3J5cHQub3JnMDwGA1UdHwQ1MDMwMaAvoC2GK2h0dHA6Ly9jcmwuaWRlbnRydXN0\nLmNvbS9EU1RST09UQ0FYM0NSTC5jcmwwHQYDVR0OBBYEFBQusxe3WFbLrlAJQOYf\nr52LFMLGMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjANBgkqhkiG9w0B\nAQsFAAOCAQEA2UzgyfWEiDcx27sT4rP8i2tiEmxYt0l+PAK3qB8oYevO4C5z70kH\nejWEHx2taPDY/laBL21/WKZuNTYQHHPD5b1tXgHXbnL7KqC401dk5VvCadTQsvd8\nS8MXjohyc9z9/G2948kLjmE6Flh9dDYrVYA9x2O+hEPGOaEOa1eePynBgPayvUfL\nqjBstzLhWVQLGAkXXmNs+5ZnPBxzDJOLxhF2JIbeQAcH5H0tZrUlo5ZYyOqA7s9p\nO5b85o3AM/OJ+CktFBQtfvBhcJVd9wvlwPsk+uyOy2HI7mNxKKgsBTt375teA2Tw\nUdHkhVNcsAKX1H7GNNLOEADksd86wuoXvg==\n-----END CERTIFICATE-----\n";
		// values.referencePhrase = "absurd cake";
		// values.enabled = false;
		// values.wifi.ssid = "";
		// values.wifi.password = "";
		printConfig(values);
	}

	Lnurl::SignerConfig getLnurlSignerConfig() {
		return values.lnurl;
	}

	BleskomatWifiConfig getWifiConfig() {
		return values.wifi;
	}

	std::string get(const char* t_key) {
		const std::string key = std::string(t_key);
		return get(key);
	}

	std::string get(const std::string &key) {
		return getConfigValue(key, values);
	}

	unsigned short getFiatPrecision() {
		return values.fiatPrecision;
	}

	double getExchangeRate() {
		return values.exchangeRate;
	}

	double getBuyLimit() {
		return values.buyLimit;
	}

	std::vector<float> getCoinValues() {
		return values.coinValues;
	}

	std::vector<float> getBillValues() {
		return values.billValues;
	}

	bool isEnabled() {
		return values.enabled;
	}

	ValuesMap parseConfigLines(const std::string &lines) {
		ValuesMap valuesMap;
		try {
			std::istringstream stream(lines);
			const std::string keyValueDelimiter = "=";
			std::string line = "";
			while (std::getline(stream, line)) {
				const auto pos = line.find(keyValueDelimiter);
				if (pos != std::string::npos) {
					const std::string key = line.substr(0, pos);
					const std::string value = line.substr(pos + 1);
					valuesMap[key] = value;
				}
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
		return valuesMap;
	}

	// Save (allowed) configurations to NVS.
	bool saveConfigurations(const ValuesMap &valuesMap) {
		if (!nvs_available) {
			if (!initNVS()) {
				return false;
			}
		}
		for (int index = 0; index < allowSaveConfigKeys.size(); index++) {
			const std::string key = allowSaveConfigKeys[index];
			if (valuesMap.find(key) != valuesMap.end()) {
				const std::string value = valuesMap.at(key);
				if (value != getConfigValue(key, nvs_values)) {
					// Configuration has been changed.
					// Save the new value to non-volatile storage.
					if (!saveKeyValueToNVS(key, value)) {
						logger::write("Failed to save configuration to non-volatile storage ( " + key + "=" + value + " )");
					}
				}
				setConfigValue(key, value, values);
			}
		}
		endNVS();
		return true;
	}
}
