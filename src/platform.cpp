#include "platform.h"

// WebSocket implementation for ESP32:
// https://docs.espressif.com/projects/esp-idf/en/latest/esp32s2/api-reference/protocols/esp_websocket_client.html
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/include/esp_websocket_client.h
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/esp_websocket_client.c
// https://github.com/espressif/esp-idf/blob/master/examples/protocols/websocket/main/websocket_example.c

// ArduinoJson documentation:
// https://arduinojson.org/

namespace {

	const char* certFileName = "platformCACert.pem";

	float exchangeRate = 0.00;
	unsigned long lastExchangeRateRefreshTime = 0;
	const unsigned int exchangeRateMaxAge = 300000;// milliseconds

	unsigned long lastReconnectAttemptTime = 0;
	const unsigned int reconnectDelay = 30000;// milliseconds

	enum class State {
		UNINITIALIZED,
		INITIALIZED,
		FAILED,
		DISCONNECTED,
		CONNECTED,
		CLOSING,
		UNAUTHORIZED,
		AUTHORIZED
	};
	State state = State::UNINITIALIZED;
	esp_websocket_client_handle_t client;

	void sendMessage(const std::string &message) {
		try {
			const char* data = message.c_str();
			logger::write("[Platform] Sending message: " + message);
			esp_websocket_client_send_text(client, data, strlen(data), portMAX_DELAY);
		} catch (const std::exception &e) {
			logger::write("[Platform] " + std::string(e.what()), "error");
		}
	}

	void onMessage(const std::string &message) {
		try {
			if (message != "") {
				logger::write("[Platform] Received message: " + message);
				// !! Important !!
				// Keep the JsonDocument instance until done reading from the deserialized document; more info:
				// https://arduinojson.org/v6/issues/garbage-out/
				DynamicJsonDocument docIn(1024);
				const DeserializationError err = deserializeJson(docIn, message);
				if (err) {
					throw std::runtime_error("deserializeJson failed: " + std::string(err.c_str()));
				}
				const JsonObject json = docIn.as<JsonObject>();
				const std::string type = json["type"].as<const char*>();
				if (type == "authorization") {
					if (json["data"].containsKey("challenge")) {
						const std::string challenge = json["data"]["challenge"];
						const std::string signature = util::createSignature(challenge);
						Lnurl::SignerConfig signerConfig = config::getLnurlSignerConfig();
						DynamicJsonDocument docOut(1024);
						docOut["id"] = signerConfig.apiKey.id.c_str();
						docOut["signature"] = signature.c_str();
						std::string json_string;
						serializeJson(docOut, json_string);
						sendMessage(json_string);
					} else if (json["data"].containsKey("success")) {
						const bool success = json["data"]["success"];
						if (success) {
							logger::write("[Platform] WebSocket authorized");
							state = State::AUTHORIZED;
						}
					}
				} else if (type == "deviceOptions") {
					config::saveConfigurations(json["data"]);
				} else if (type == "exchangeRate") {
					const std::string fiatCurrency = json["data"]["fiatCurrency"];
					if (fiatCurrency == config::getString("fiatCurrency")) {
						exchangeRate = std::strtod(json["data"]["exchangeRate"], NULL);
						lastExchangeRateRefreshTime = millis();
					} else {
						logger::write("[Platform] Received exchange rate currency (\"" + config::getString("fiatCurrency") + "\") does not match the device's fiatCurrency option (\"" + fiatCurrency + "\")");
					}
				} else if (type == "error") {
					const std::string message = json["message"];
					if (state == State::CONNECTED) {
						state = State::UNAUTHORIZED;
					}
				} else {
					logger::write("[Platform] Unknown message type: " + type);
				}
			}
		} catch (const std::exception &e) {
			logger::write("[Platform] " + std::string(e.what()), "error");
		}
	}

	void websocket_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
		try {
			esp_websocket_event_data_t *data = (esp_websocket_event_data_t *)event_data;
			if (event_id == WEBSOCKET_EVENT_CONNECTED) {
				logger::write("[Platform] WebSocket connected");
				state = State::CONNECTED;
			} else if (event_id == WEBSOCKET_EVENT_DISCONNECTED) {
				logger::write("[Platform] WebSocket disconnected");
				state = State::DISCONNECTED;
			} else if (event_id == WEBSOCKET_EVENT_DATA) {
				onMessage(std::string(data->data_ptr, data->payload_offset, data->payload_len));
			}
		} catch (const std::exception &e) {
			logger::write("[Platform] " + std::string(e.what()), "error");
		}
	}

	void initialize() {
		try {
			esp_websocket_client_config_t websocket_cfg = {};
			// We implement our own reconnection logic.
			websocket_cfg.disable_auto_reconnect = true;
			const std::string uri = config::getString("platformSockUri");
			if (config::getBool("strictTls") && uri.substr(0, 6) == "wss://") {
				if (sdcard::fileExists(certFileName)) {
					const char* cert = sdcard::readFile(certFileName).c_str();
					if (strlen(cert) > 0) {
						websocket_cfg.cert_pem = cert;
					}
				} else {
					throw std::runtime_error("Initialization failed: Missing " + std::string(certFileName));
				}
			}
			websocket_cfg.uri = uri.c_str();
			websocket_cfg.user_agent = (char *)network::getUserAgent().c_str();
			logger::write("[Platform] Initializing WebSocket connection to " + uri);
			client = esp_websocket_client_init(&websocket_cfg);
			esp_websocket_register_events(client, WEBSOCKET_EVENT_ANY, websocket_event_handler, (void *)client);
			const esp_err_t result = esp_websocket_client_start(client);
			if (result == ESP_OK) {
				state = State::INITIALIZED;
			} else {
				state = State::FAILED;
			}
		} catch (const std::exception &e) {
			state = State::FAILED;
			logger::write("[Platform] " + std::string(e.what()), "error");
		}
	}

	void close() {
		if (state != State::CLOSING) {
			try {
				logger::write("[Platform] Closing WebSocket connection...");
				state = State::CLOSING;
				esp_websocket_client_stop(client);
				esp_websocket_client_destroy(client);
			} catch (const std::exception &e) {
				logger::write("[Platform] " + std::string(e.what()), "error");
			}
		}
	}
}

namespace platform {

	void loop() {
		if (platform::isConfigured()) {
			if (network::isConnected()) {
				if (
					state == State::UNINITIALIZED &&
					(
						lastReconnectAttemptTime == 0 ||
						millis() - lastReconnectAttemptTime > reconnectDelay
					)
				) {
					initialize();
					lastReconnectAttemptTime = millis();
				} else if (state == State::UNAUTHORIZED) {
					close();
					// Do not reset the state to prevent a reconnection attempt.
				} else if (state == State::DISCONNECTED) {
					close();
					// Set state back to uninitialized so that we can reconnect later.
					state = State::UNINITIALIZED;
				}
			} else {
				// No network connection.
				if (state != State::UNINITIALIZED) {
					close();
					state = State::UNINITIALIZED;
				}
			}
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
			logger::write("[Platform] " + std::string(e.what()), "error");
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
