#include "network.h"

// WiFi library usage examples:
// https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFi/examples

// How to listen for various WiFi-related events:
// https://github.com/espressif/arduino-esp32/blob/master/libraries/WiFi/examples/WiFiClientEvents/WiFiClientEvents.ino

namespace {

	std::string ssid;
	std::string password;

	unsigned long lastConnectionAttemptTime = 0;
	const unsigned int connectionAttemptDelay = 10000;// milliseconds

	void logWiFiEvent(WiFiEvent_t event) {
		switch (event) {
			case SYSTEM_EVENT_WIFI_READY:
				logger::write("WiFi interface ready");
				break;
			case SYSTEM_EVENT_SCAN_DONE:
				logger::write("Completed scan for access points");
				break;
			case SYSTEM_EVENT_STA_START:
				logger::write("WiFi client started");
				break;
			case SYSTEM_EVENT_STA_STOP:
				logger::write("WiFi clients stopped");
				break;
			case SYSTEM_EVENT_STA_CONNECTED:
				logger::write("Connected to access point");
				break;
			case SYSTEM_EVENT_STA_DISCONNECTED:
				logger::write("Disconnected from WiFi access point");
				break;
			case SYSTEM_EVENT_STA_AUTHMODE_CHANGE:
				logger::write("Authentication mode of access point has changed");
				break;
			case SYSTEM_EVENT_STA_GOT_IP:
				logger::write("Obtained IP address: " + std::string(WiFi.localIP().toString().c_str()));
				break;
			case SYSTEM_EVENT_STA_LOST_IP:
				logger::write("Lost IP address and IP address is reset to 0");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_SUCCESS:
				logger::write("WiFi Protected Setup (WPS): succeeded in enrollee mode");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_FAILED:
				logger::write("WiFi Protected Setup (WPS): failed in enrollee mode");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_TIMEOUT:
				logger::write("WiFi Protected Setup (WPS): timeout in enrollee mode");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_PIN:
				logger::write("WiFi Protected Setup (WPS): pin code in enrollee mode");
				break;
			case SYSTEM_EVENT_AP_START:
				logger::write("WiFi access point started");
				break;
			case SYSTEM_EVENT_AP_STOP:
				logger::write("WiFi access point  stopped");
				break;
			case SYSTEM_EVENT_AP_STACONNECTED:
				logger::write("Client connected");
				break;
			case SYSTEM_EVENT_AP_STADISCONNECTED:
				logger::write("Client disconnected");
				break;
			case SYSTEM_EVENT_AP_STAIPASSIGNED:
				logger::write("Assigned IP address to client");
				break;
			case SYSTEM_EVENT_AP_PROBEREQRECVED:
				logger::write("Received probe request");
				break;
			case SYSTEM_EVENT_GOT_IP6:
				logger::write("IPv6 is preferred");
				break;
			case SYSTEM_EVENT_ETH_START:
				logger::write("Ethernet started");
				break;
			case SYSTEM_EVENT_ETH_STOP:
				logger::write("Ethernet stopped");
				break;
			case SYSTEM_EVENT_ETH_CONNECTED:
				logger::write("Ethernet connected");
				break;
			case SYSTEM_EVENT_ETH_DISCONNECTED:
				logger::write("Ethernet disconnected");
				break;
			case SYSTEM_EVENT_ETH_GOT_IP:
				logger::write("Obtained IP address");
				break;
			default:
				break;
		}
	}
}

namespace network {

	void init() {
		ssid = config::getString("wifi.ssid");
		password = config::getString("wifi.password");
		WiFi.mode(WIFI_OFF);
		WiFi.onEvent(logWiFiEvent);
	}

	void loop() {
		const int status = WiFi.status();
		if (status == WL_CONNECTED) {
			if (lastConnectionAttemptTime > 0) {
				logger::write("Connected to WiFi network");
				lastConnectionAttemptTime = 0;
			}
		} else if (status != WL_IDLE_STATUS && (lastConnectionAttemptTime == 0 || millis() - lastConnectionAttemptTime >= connectionAttemptDelay)) {
			if (ssid != "") {
				lastConnectionAttemptTime = millis();
				try {
					WiFi.begin(ssid.c_str(), password.c_str());
					WiFi.mode(WIFI_MODE_STA);// Set "Station" mode.
				} catch (const std::exception &e) {
					logger::write("Error while connecting to WiFi: " + std::string(e.what()), "error");
				}
			}
		}
	}

	bool isConnected() {
		return WiFi.status() == WL_CONNECTED;
	}

	std::string getUserAgent() {
		return firmwareName + " " + firmwareVersion;
	}
}
