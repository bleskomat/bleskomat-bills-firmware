#include "ping-server.h"

// WebSocket implementation for ESP32:
// https://docs.espressif.com/projects/esp-idf/en/latest/esp32s2/api-reference/protocols/esp_websocket_client.html
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/include/esp_websocket_client.h
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/esp_websocket_client.c
// https://github.com/espressif/esp-idf/blob/master/examples/protocols/websocket/main/websocket_example.c

namespace {

	const char* certFileName = "pingCACert.pem";

	unsigned long lastReconnectAttemptTime = 0;
	const unsigned int reconnectDelay = 30000;// milliseconds

	enum class State {
		UNINITIALIZED,
		INITIALIZED,
		FAILED,
		DISCONNECTED,
		CONNECTED,
		CLOSING
	};
	State state = State::UNINITIALIZED;
	esp_websocket_client_handle_t client;

	void websocket_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
		try {
			if (event_id == WEBSOCKET_EVENT_CONNECTED) {
				logger::write("[Ping Server] WebSocket connected");
				state = State::CONNECTED;
			} else if (event_id == WEBSOCKET_EVENT_DISCONNECTED) {
				logger::write("[Ping Server] WebSocket disconnected");
				state = State::DISCONNECTED;
			}
		} catch (const std::exception &e) {
			logger::write("[Ping Server] " + std::string(e.what()), "error");
		}
	}

	void initialize() {
		try {
			esp_websocket_client_config_t websocket_cfg = {};
			// We implement our own reconnection logic.
			websocket_cfg.disable_auto_reconnect = true;
			const std::string uri = config::getString("pingSockUri");
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
			logger::write("[Ping Server] Initializing WebSocket connection to " + uri);
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
			logger::write("[Ping Server] " + std::string(e.what()), "error");
		}
	}

	void close() {
		if (state != State::CLOSING) {
			try {
				logger::write("[Ping Server] Closing WebSocket connection...");
				state = State::CLOSING;
				esp_websocket_client_stop(client);
				esp_websocket_client_destroy(client);
			} catch (const std::exception &e) {
				logger::write("[Ping Server] " + std::string(e.what()), "error");
			}
		}
	}
}

namespace pingServer {

	void loop() {
		if (pingServer::isConfigured()) {
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
		return config::getString("pingSockUri") != "";
	}

	bool isConnected() {
		try {
			return esp_websocket_client_is_connected(client);
		} catch (const std::exception &e) {
			logger::write("[Ping Server] " + std::string(e.what()), "error");
			return false;
		}
	}
}
