#include "platform.h"

// WebSocket implementation for ESP32:
// https://docs.espressif.com/projects/esp-idf/en/latest/esp32s2/api-reference/protocols/esp_websocket_client.html
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/include/esp_websocket_client.h
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/esp_websocket_client.c
// https://github.com/espressif/esp-idf/blob/master/examples/protocols/websocket/main/websocket_example.c

// ArduinoJson documentation:
// https://arduinojson.org/

namespace {

	double exchangeRate = 0.00;
	unsigned long lastExchangeRateRefreshTime = 0;
	unsigned long exchangeRateMaxAge = 300000;// milliseconds

	enum class State {
		UNINITIALIZED,
		INITIALIZED,
		FAILED,
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
			std::cerr << e.what() << std::endl;
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
				const std::string type = json["type"].as<char*>();
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
					if (fiatCurrency == config::get("fiatCurrency")) {
						exchangeRate = std::strtod(json["data"]["exchangeRate"], NULL);
						lastExchangeRateRefreshTime = millis();
					} else {
						logger::write("[Platform] Received exchange rate currency (\"" + config::get("fiatCurrency") + "\") does not match the device's fiatCurrency option (\"" + fiatCurrency + "\")");
					}
				} else if (type == "error") {
					const std::string message = json["message"];
				} else {
					logger::write("[Platform] Unknown message type: " + type);
				}
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
	}

	void websocket_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
		try {
			esp_websocket_event_data_t *data = (esp_websocket_event_data_t *)event_data;
			if (event_id == WEBSOCKET_EVENT_CONNECTED) {
				logger::write("[Platform] WebSocket connected");
			} else if (event_id == WEBSOCKET_EVENT_DISCONNECTED) {
				logger::write("[Platform] WebSocket disconnected");
				state = State::INITIALIZED;
			} else if (event_id == WEBSOCKET_EVENT_DATA) {
				onMessage(std::string(data->data_ptr, data->payload_offset, data->payload_len));
			} else if (event_id == WEBSOCKET_EVENT_ERROR) {
				logger::write("[Platform] WebSocket error");
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
	}

	void initialize() {
		try {
			esp_websocket_client_config_t websocket_cfg = {};
			const std::string uri = config::get("platformSockUri");
			const std::string cert = config::get("platformCACert");
			logger::write("[Platform] Initializing WebSocket connection to " + uri);
			websocket_cfg.uri = uri.c_str();
			websocket_cfg.user_agent = (char *)network::getUserAgent().c_str();
			if (cert != "") {
				websocket_cfg.cert_pem = cert.c_str();
			}
			client = esp_websocket_client_init(&websocket_cfg);
			esp_websocket_register_events(client, WEBSOCKET_EVENT_ANY, websocket_event_handler, (void *)client);
			esp_err_t result = esp_websocket_client_start(client);
			if (result == ESP_OK) {
				state = State::INITIALIZED;
			} else {
				state = State::FAILED;
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
	}

	void close() {
		try {
			logger::write("[Platform] Closing WebSocket connection...");
			esp_websocket_client_stop(client);
			esp_websocket_client_destroy(client);
			state = State::UNINITIALIZED;
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
	}
}

namespace platform {

	void loop() {
		if (platform::isConfigured()) {
			if (network::isConnected()) {
				if (state == State::UNINITIALIZED) {
					initialize();
				}
			} else {
				// No network connection.
				if (isConnected()) {
					close();
				}
			}
		}
	}

	bool isConfigured() {
		return config::get("platformSockUri") != "";
	}

	bool isConnected() {
		return esp_websocket_client_is_connected(client);
	}

	double getExchangeRate() {
		if ((lastExchangeRateRefreshTime == 0 || millis() - lastExchangeRateRefreshTime >= exchangeRateMaxAge)) {
			// Exchange rate is stale.
			// Return 0, indicating that the exchange rate value should not be used.
			return 0.00;
		}
		return exchangeRate;
	}
}
