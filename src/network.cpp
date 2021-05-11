#include "network.h"

// WiFi library usage examples:
// https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFi/examples

// How to listen for various WiFi-related events:
// https://github.com/espressif/arduino-esp32/blob/master/libraries/WiFi/examples/WiFiClientEvents/WiFiClientEvents.ino

// ArduinoJson documentation:
// https://arduinojson.org/

namespace {

	unsigned long lastConnectionAttemptTime = 0;
	unsigned long connectionAttemptDelay = 10000;// milliseconds

	double exchangeRate = 0.00;
	unsigned long lastExchangeRateRefreshTime = 0;
	unsigned long exchangeRateMaxAge = 300000;// milliseconds

	// Un-comment the following to print all events related to the WiFi module:
	// void logWiFiEvent(WiFiEvent_t event) {
	// 	switch (event) {
	// 		case SYSTEM_EVENT_WIFI_READY: 
	// 			logger::write("WiFi interface ready");
	// 			break;
	// 		case SYSTEM_EVENT_SCAN_DONE:
	// 			logger::write("Completed scan for access points");
	// 			break;
	// 		case SYSTEM_EVENT_STA_START:
	// 			logger::write("WiFi client started");
	// 			break;
	// 		case SYSTEM_EVENT_STA_STOP:
	// 			logger::write("WiFi clients stopped");
	// 			break;
	// 		case SYSTEM_EVENT_STA_CONNECTED:
	// 			logger::write("Connected to access point");
	// 			break;
	// 		case SYSTEM_EVENT_STA_DISCONNECTED:
	// 			logger::write("Disconnected from WiFi access point");
	// 			break;
	// 		case SYSTEM_EVENT_STA_AUTHMODE_CHANGE:
	// 			logger::write("Authentication mode of access point has changed");
	// 			break;
	// 		case SYSTEM_EVENT_STA_GOT_IP:
	// 			logger::write("Obtained IP address: " + std::string(WiFi.localIP().toString().c_str()));
	// 			break;
	// 		case SYSTEM_EVENT_STA_LOST_IP:
	// 			logger::write("Lost IP address and IP address is reset to 0");
	// 			break;
	// 		case SYSTEM_EVENT_STA_WPS_ER_SUCCESS:
	// 			logger::write("WiFi Protected Setup (WPS): succeeded in enrollee mode");
	// 			break;
	// 		case SYSTEM_EVENT_STA_WPS_ER_FAILED:
	// 			logger::write("WiFi Protected Setup (WPS): failed in enrollee mode");
	// 			break;
	// 		case SYSTEM_EVENT_STA_WPS_ER_TIMEOUT:
	// 			logger::write("WiFi Protected Setup (WPS): timeout in enrollee mode");
	// 			break;
	// 		case SYSTEM_EVENT_STA_WPS_ER_PIN:
	// 			logger::write("WiFi Protected Setup (WPS): pin code in enrollee mode");
	// 			break;
	// 		case SYSTEM_EVENT_AP_START:
	// 			logger::write("WiFi access point started");
	// 			break;
	// 		case SYSTEM_EVENT_AP_STOP:
	// 			logger::write("WiFi access point  stopped");
	// 			break;
	// 		case SYSTEM_EVENT_AP_STACONNECTED:
	// 			logger::write("Client connected");
	// 			break;
	// 		case SYSTEM_EVENT_AP_STADISCONNECTED:
	// 			logger::write("Client disconnected");
	// 			break;
	// 		case SYSTEM_EVENT_AP_STAIPASSIGNED:
	// 			logger::write("Assigned IP address to client");
	// 			break;
	// 		case SYSTEM_EVENT_AP_PROBEREQRECVED:
	// 			logger::write("Received probe request");
	// 			break;
	// 		case SYSTEM_EVENT_GOT_IP6:
	// 			logger::write("IPv6 is preferred");
	// 			break;
	// 		case SYSTEM_EVENT_ETH_START:
	// 			logger::write("Ethernet started");
	// 			break;
	// 		case SYSTEM_EVENT_ETH_STOP:
	// 			logger::write("Ethernet stopped");
	// 			break;
	// 		case SYSTEM_EVENT_ETH_CONNECTED:
	// 			logger::write("Ethernet connected");
	// 			break;
	// 		case SYSTEM_EVENT_ETH_DISCONNECTED:
	// 			logger::write("Ethernet disconnected");
	// 			break;
	// 		case SYSTEM_EVENT_ETH_GOT_IP:
	// 			logger::write("Obtained IP address");
	// 			break;
	// 		default:
	// 			break;
	// 	}
	// }

	void tryConnectWithConfig(const BleskomatWifiConfig &wifiConfig) {
		lastConnectionAttemptTime = millis();
		WiFi.begin(wifiConfig.ssid.c_str(), wifiConfig.password.c_str());
		// Set "Station" mode.
		WiFi.mode(WIFI_MODE_STA);
	}

	namespace ws {

		// WebSocket implementation for ESP32:
		// https://docs.espressif.com/projects/esp-idf/en/latest/esp32s2/api-reference/protocols/esp_websocket_client.html
		// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/include/esp_websocket_client.h
		// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/esp_websocket_client.c
		// https://github.com/espressif/esp-idf/blob/master/examples/protocols/websocket/main/websocket_example.c

		enum class State {
			UNINITIALIZED,
			INITIALIZED,
			FAILED,
			AUTHORIZED
		};
		State state = State::UNINITIALIZED;
		esp_websocket_client_handle_t client;

		void sendMessage(const std::string &message) {
			const char* data = message.c_str();
			logger::write("WEBSOCKET_WRITE: " + message);
			esp_websocket_client_send_text(client, data, strlen(data), portMAX_DELAY);
		}

		void onMessage(const std::string &message) {
			try {
				if (message != "") {
					logger::write("WEBSOCKET_MESSAGE: " + message);
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
								logger::write("WEBSOCKET_AUTHORIZED");
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
							logger::write("WEBSOCKET_EXCHANGE_RATE: Fiat currency mis-match");
						}
					} else if (type == "error") {
						const std::string message = json["message"];
					} else {
						logger::write("WEBSOCKET_UNKNOWN_MESSAGE_TYPE: " + type);
					}
				}
			} catch (const std::exception &e) {
				std::cerr << e.what() << std::endl;
			}
		}

		void websocket_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
			esp_websocket_event_data_t *data = (esp_websocket_event_data_t *)event_data;
			if (event_id == WEBSOCKET_EVENT_CONNECTED) {
				logger::write("WEBSOCKET_EVENT_CONNECTED");
			} else if (event_id == WEBSOCKET_EVENT_DISCONNECTED) {
				logger::write("WEBSOCKET_EVENT_DISCONNECTED");
				state = State::INITIALIZED;
			} else if (event_id == WEBSOCKET_EVENT_DATA) {
				onMessage(std::string(data->data_ptr, data->payload_offset, data->payload_len));
			} else if (event_id == WEBSOCKET_EVENT_ERROR) {
				logger::write("WEBSOCKET_EVENT_ERROR");
			}
		}

		void initialize() {
			esp_websocket_client_config_t websocket_cfg = {};
			const std::string webSocketUri = config::get("webSocketUri");
			const std::string webCACert = config::get("webCACert");
			logger::write("Initializing websocket connection to " + webSocketUri);
			websocket_cfg.uri = webSocketUri.c_str();
			if (webCACert != "") {
				websocket_cfg.cert_pem = (char *)webCACert.c_str();
			}
			client = esp_websocket_client_init(&websocket_cfg);
			esp_websocket_register_events(client, WEBSOCKET_EVENT_ANY, websocket_event_handler, (void *)client);
			esp_err_t result = esp_websocket_client_start(client);
			if (result == ESP_OK) {
				state = State::INITIALIZED;
			} else {
				state = State::FAILED;
			}
		}

		void close() {
			logger::write("Closing websocket connection...");
			esp_websocket_client_stop(client);
			esp_websocket_client_destroy(client);
			state = State::UNINITIALIZED;
		}

		bool isConnected() {
			return esp_websocket_client_is_connected(client);
		}
	}
}

namespace network {

	void init() {
		WiFi.mode(WIFI_OFF);
		// Un-comment the following to print all events related to the WiFi module:
		// WiFi.onEvent(logWiFiEvent);
	}

	void loop() {
		const int status = WiFi.status();
		if (
			status != WL_CONNECTED &&
			status != WL_IDLE_STATUS &&
			(lastConnectionAttemptTime == 0 || millis() - lastConnectionAttemptTime >= connectionAttemptDelay)
		) {
			const BleskomatWifiConfig wifiConfig = config::getWifiConfig();
			if (wifiConfig.ssid != "") {
				try {
					logger::write("Connecting to WiFi network...");
					logger::write("SSID: " + wifiConfig.ssid);
					logger::write("Password: " + wifiConfig.password);
					tryConnectWithConfig(wifiConfig);
				} catch (const std::exception &e) {
					logger::write(e.what());
				}
			}
		} else if (status == WL_CONNECTED) {
			if (lastConnectionAttemptTime > 0) {
				logger::write("Connected to WiFi network");
				lastConnectionAttemptTime = 0;
			}
			if (ws::state == ws::State::UNINITIALIZED) {
				if (config::get("webSocketUri") != "") {
					ws::initialize();
				}
			}
		} else {
			// WiFi not connected.
			if (ws::isConnected()) {
				ws::close();
			}
		}
	}

	void connect() {
		const BleskomatWifiConfig wifiConfig = config::getWifiConfig();
		tryConnectWithConfig(wifiConfig);
	}

	bool isConnected() {
		return WiFi.status() == WL_CONNECTED;
	}

	bool isConnectedToWebServer() {
		return network::isConnected() && ws::isConnected() && ws::state == ws::State::AUTHORIZED;
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
