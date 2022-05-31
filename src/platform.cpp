#include "platform.h"

// ESP32 WebSocket Client:
// https://espressif.github.io/esp-protocols/esp_websocket_client/index.html

// ArduinoJson:
// https://arduinojson.org/

namespace {

	// Configurations which can be changed via the connection to the platform:
	const std::vector<const char*> allowSaveConfigKeys = {
		"enabled",
		"buyLimit",
		"feePercent"
	};

	bool initialized = false;
	esp_websocket_client_handle_t client;
	std::string platformCACert;
	float exchangeRate = 0.00;
	unsigned long lastExchangeRateRefreshTime = 0;
	const unsigned int exchangeRateMaxAge = 300000;// milliseconds

	void sendMessage(const std::string &message) {
		try {
			const char* data = message.c_str();
			logger::write("Sending message to platform: " + message);
			esp_websocket_client_send_text(client, data, strlen(data), portMAX_DELAY);
		} catch (const std::exception &e) {
			logger::write("Error while sending message to platform: " + std::string(e.what()), "error");
		}
	}

	void onMessage(const std::string &message) {
		try {
			if (message == "" || message.substr(0, 1) != "{") return;
			logger::write("Received message from platform: " + message);
			// !! Important !!
			// Keep the JsonDocument instance until done reading from the deserialized document; more info:
			// https://arduinojson.org/v6/issues/garbage-out/
			DynamicJsonDocument docIn(1024);
			const DeserializationError deserializationError = deserializeJson(docIn, message);
			if (deserializationError) {
				std::cerr << "deserializeJson error: " << deserializationError.c_str();
				throw std::runtime_error("Invalid JSON");
			}
			const JsonObject data = docIn.as<JsonObject>();
			const std::string type = data["type"].as<const char*>();
			if (type == "authorization") {
				if (!data.containsKey("data")) {
					throw std::runtime_error("Missing required property: \"data\"");
				}
				if (data["data"].containsKey("challenge")) {
					const std::string challenge = data["data"]["challenge"];
					const std::string signature = util::createSignature(challenge);
					const Lnurl::SignerConfig signerConfig = config::getLnurlSignerConfig();
					DynamicJsonDocument docOut(1024);
					docOut["id"] = signerConfig.apiKey.id.c_str();
					docOut["signature"] = signature.c_str();
					std::string output;
					serializeJson(docOut, output);
					sendMessage(output);
				} else if (data["data"].containsKey("success")) {
					const bool success = data["data"]["success"];
					if (success) {
						logger::write("Connection to platform authorized successfully");
					}
				}
			} else if (type == "deviceOptions") {
				if (!data.containsKey("data")) {
					throw std::runtime_error("Missing required property: \"data\"");
				}
				DynamicJsonDocument doc(1024);
				for (const char* key : allowSaveConfigKeys) {
					if (data["data"].containsKey(key)) {
						if (key == "enabled") {
							const bool enabled = data["data"][key].as<const bool>();
							doc[key] = enabled == true ? "true" : "false";
						} else {
							doc[key] = data["data"][key].as<const char*>();
						}
					}
				}
				config::saveConfigurations(doc.as<JsonObject>());
			} else if (type == "exchangeRate") {
				if (!data.containsKey("data")) {
					throw std::runtime_error("Missing required property: \"data\"");
				}
				if (!data["data"].containsKey("fiatCurrency")) {
					throw std::runtime_error("Missing required property: \"data.fiatCurrency\"");
				}
				if (!data["data"].containsKey("exchangeRate")) {
					throw std::runtime_error("Missing required property: \"data.exchangeRate\"");
				}
				const std::string fiatCurrency = data["data"]["fiatCurrency"];
				if (fiatCurrency != config::getString("fiatCurrency")) {
					throw std::runtime_error("Received exchange rate currency (\"" + fiatCurrency + "\") does not match the device's fiatCurrency option (\"" + config::getString("fiatCurrency") + "\")");
				}
				exchangeRate = std::strtod(data["data"]["exchangeRate"], NULL);
				lastExchangeRateRefreshTime = millis();
			} else if (type == "error") {
				const std::string message = data["message"];
				logger::write("Received error message from platform: " + message);
			} else {
				throw std::runtime_error("Unknown message type: " + type);
			}
		} catch (const std::exception &e) {
			logger::write("Error while handling message from platform: " + std::string(e.what()), "error");
		}
	}

	void websocket_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
		try {
			esp_websocket_event_data_t *data = (esp_websocket_event_data_t *)event_data;
			if (event_id == WEBSOCKET_EVENT_CONNECTED) {
				logger::write("Websocket connected to platform");
			} else if (event_id == WEBSOCKET_EVENT_DISCONNECTED) {
				logger::write("Websocket disconnected from platform");
			} else if (event_id == WEBSOCKET_EVENT_DATA) {
				onMessage(std::string(data->data_ptr, data->payload_offset, data->payload_len));
			}
		} catch (const std::exception &e) {
			logger::write("Error while handling platform websocket event: " + std::string(e.what()), "error");
		}
	}

	void initialize() {
		try {
			const std::string platformSockUri = config::getString("platformSockUri");
			logger::write("Initializing connection to platform at " + platformSockUri);
			esp_websocket_client_config_t websocket_cfg = {};
			if (platformSockUri.substr(0, 6) == "wss://") {
				// !! IMPORTANT !!
				// Do not locally scope the platform CA certificate variable.
				// The cert data must survive in-memory until the websocket client (mbed tls) can read it.
				platformCACert = config::getString("platformCACert");
				if (platformCACert == "") {
					throw std::runtime_error("Missing required config: \"platformCACert\"");
				}
				websocket_cfg.cert_pem = (const char*)platformCACert.c_str();
				websocket_cfg.skip_cert_common_name_check = config::getBool("strictTls") == false;
			}
			websocket_cfg.uri = platformSockUri.c_str();
			websocket_cfg.user_agent = (char *)network::getUserAgent().c_str();
			client = esp_websocket_client_init(&websocket_cfg);
			logger::write("client = esp_websocket_client_init");
			const esp_err_t registerEventsResult = esp_websocket_register_events(client, WEBSOCKET_EVENT_ANY, websocket_event_handler, (void *)client);
			logger::write("esp_websocket_register_events: " + std::string(esp_err_to_name(registerEventsResult)), "debug");
			const esp_err_t startResult = esp_websocket_client_start(client);
			logger::write("esp_websocket_client_start: " + std::string(esp_err_to_name(startResult)), "debug");
		} catch (const std::exception &e) {
			logger::write("Error while initializing connection to platform: " + std::string(e.what()), "error");
		}
		initialized = true;
	}
}

namespace platform {

	void loop() {
		if (!initialized && platform::isConfigured() && network::isConnected()) {
			initialize();
		}
	}

	bool isConfigured() {
		if (config::getString("platformSockUri") == "") {
			return false;
		}
		const Lnurl::SignerConfig signerConfig = config::getLnurlSignerConfig();
		if (signerConfig.apiKey.id == "" || signerConfig.apiKey.key == "") {
			return false;
		}
		return true;
	}

	bool isConnected() {
		try {
			return esp_websocket_client_is_connected(client);
		} catch (const std::exception &e) {
			logger::write("Error while checking if platform websocket connected: " + std::string(e.what()), "error");
			return false;
		}
	}

	float getExchangeRate() {
		if ((lastExchangeRateRefreshTime == 0 || millis() - lastExchangeRateRefreshTime >= exchangeRateMaxAge)) {
			// Exchange rate is stale.
			// Return 0, indicating that the exchange rate value should not be used.
			return 0.00;
		}
		return exchangeRate;
	}
}
