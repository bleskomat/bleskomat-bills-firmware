#include "ping-server.h"

// WebSocket implementation for ESP32:
// https://docs.espressif.com/projects/esp-idf/en/latest/esp32s2/api-reference/protocols/esp_websocket_client.html
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/include/esp_websocket_client.h
// https://github.com/espressif/esp-idf/blob/master/components/esp_websocket_client/esp_websocket_client.c
// https://github.com/espressif/esp-idf/blob/master/examples/protocols/websocket/main/websocket_example.c

namespace {

	enum class State {
		UNINITIALIZED,
		INITIALIZED,
		FAILED,
		DISCONNECTED,
		CONNECTED
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
			} else if (event_id == WEBSOCKET_EVENT_ERROR) {
				logger::write("[Ping Server] WebSocket error");
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
	}

	void initialize() {
		try {
			esp_websocket_client_config_t websocket_cfg = {};
			const std::string uri = config::get("pingSockUri");
			const std::string cert = config::get("pingCACert").c_str();
			logger::write("[Ping Server] Initializing WebSocket connection to " + uri);
			websocket_cfg.uri = uri.c_str();
			websocket_cfg.user_agent = (char *)network::getUserAgent().c_str();
			if (cert != "") {
				websocket_cfg.cert_pem = cert.c_str();
				std::cout << "CERT:\n" << websocket_cfg.cert_pem << std::endl;
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
			logger::write("[Ping Server] Closing WebSocket connection...");
			esp_websocket_client_stop(client);
			esp_websocket_client_destroy(client);
			state = State::UNINITIALIZED;
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
	}
}

namespace pingServer {

	void loop() {
		if (pingServer::isConfigured()) {
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
		return config::get("pingSockUri") != "";
	}

	bool isConnected() {
		return esp_websocket_client_is_connected(client);
	}
}
