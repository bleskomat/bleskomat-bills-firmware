#include "network.h"

// WiFi library usage examples:
// https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFi/examples

// How to listen for various WiFi-related events:
// https://github.com/espressif/arduino-esp32/blob/master/libraries/WiFi/examples/WiFiClientEvents/WiFiClientEvents.ino

// How to make HTTP requests:
// https://github.com/espressif/arduino-esp32/blob/master/libraries/WiFi/examples/WiFiClient/WiFiClient.ino

namespace {

	unsigned long lastConnectionAttemptTime = 0;
	unsigned long connectionAttemptDelay = 10000;// milliseconds

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
		} else if (status == WL_CONNECTED && lastConnectionAttemptTime > 0) {
			lastConnectionAttemptTime = 0;
		}
	}

	void connect() {
		const BleskomatWifiConfig wifiConfig = config::getWifiConfig();
		tryConnectWithConfig(wifiConfig);
	}

	bool isConnected() {
		return WiFi.status() == WL_CONNECTED;
	}
}
