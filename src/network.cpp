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

	unsigned long platformDownLastChangeTime = 0;
	const unsigned int platformDownDebounceTime = 10000;// milliseconds
	bool platformDown = false;

	void logWiFiEvent(WiFiEvent_t event) {
		switch (event) {
			case SYSTEM_EVENT_WIFI_READY:
				logger::write("[Network] WiFi interface ready");
				break;
			case SYSTEM_EVENT_SCAN_DONE:
				logger::write("[Network] Completed scan for access points");
				break;
			case SYSTEM_EVENT_STA_START:
				logger::write("[Network] WiFi client started");
				break;
			case SYSTEM_EVENT_STA_STOP:
				logger::write("[Network] WiFi clients stopped");
				break;
			case SYSTEM_EVENT_STA_CONNECTED:
				logger::write("[Network] Connected to access point");
				break;
			case SYSTEM_EVENT_STA_DISCONNECTED:
				logger::write("[Network] Disconnected from WiFi access point");
				break;
			case SYSTEM_EVENT_STA_AUTHMODE_CHANGE:
				logger::write("[Network] Authentication mode of access point has changed");
				break;
			case SYSTEM_EVENT_STA_GOT_IP:
				logger::write("[Network] Obtained IP address: " + std::string(WiFi.localIP().toString().c_str()));
				break;
			case SYSTEM_EVENT_STA_LOST_IP:
				logger::write("[Network] Lost IP address and IP address is reset to 0");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_SUCCESS:
				logger::write("[Network] WiFi Protected Setup (WPS): succeeded in enrollee mode");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_FAILED:
				logger::write("[Network] WiFi Protected Setup (WPS): failed in enrollee mode");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_TIMEOUT:
				logger::write("[Network] WiFi Protected Setup (WPS): timeout in enrollee mode");
				break;
			case SYSTEM_EVENT_STA_WPS_ER_PIN:
				logger::write("[Network] WiFi Protected Setup (WPS): pin code in enrollee mode");
				break;
			case SYSTEM_EVENT_AP_START:
				logger::write("[Network] WiFi access point started");
				break;
			case SYSTEM_EVENT_AP_STOP:
				logger::write("[Network] WiFi access point  stopped");
				break;
			case SYSTEM_EVENT_AP_STACONNECTED:
				logger::write("[Network] Client connected");
				break;
			case SYSTEM_EVENT_AP_STADISCONNECTED:
				logger::write("[Network] Client disconnected");
				break;
			case SYSTEM_EVENT_AP_STAIPASSIGNED:
				logger::write("[Network] Assigned IP address to client");
				break;
			case SYSTEM_EVENT_AP_PROBEREQRECVED:
				logger::write("[Network] Received probe request");
				break;
			case SYSTEM_EVENT_GOT_IP6:
				logger::write("[Network] IPv6 is preferred");
				break;
			case SYSTEM_EVENT_ETH_START:
				logger::write("[Network] Ethernet started");
				break;
			case SYSTEM_EVENT_ETH_STOP:
				logger::write("[Network] Ethernet stopped");
				break;
			case SYSTEM_EVENT_ETH_CONNECTED:
				logger::write("[Network] Ethernet connected");
				break;
			case SYSTEM_EVENT_ETH_DISCONNECTED:
				logger::write("[Network] Ethernet disconnected");
				break;
			case SYSTEM_EVENT_ETH_GOT_IP:
				logger::write("[Network] Obtained IP address");
				break;
			default:
				break;
		}
	}

	void logWiFiEvents() {
		WiFi.onEvent(logWiFiEvent);
	}

	void connectToWiFi() {
		lastConnectionAttemptTime = millis();
		try {
			WiFi.begin(ssid.c_str(), password.c_str());
			// Set "Station" mode.
			WiFi.mode(WIFI_MODE_STA);
		} catch (const std::exception &e) {
			logger::write("[Network] " + std::string(e.what()), "error");
		}
	}
}

namespace network {

	void init() {
		ssid = config::getString("wifi.ssid");
		password = config::getString("wifi.password");
		WiFi.mode(WIFI_OFF);
		// Un-comment the following line to print all events related to the WiFi module:
		// logWiFiEvents();
	}

	void loop() {
		const int status = WiFi.status();
		if (
			status != WL_CONNECTED &&
			status != WL_IDLE_STATUS &&
			(lastConnectionAttemptTime == 0 || millis() - lastConnectionAttemptTime >= connectionAttemptDelay)
		) {
			if (ssid != "") {
				logger::write("[Network] Connecting to WiFi network (SSID = \"" + ssid + "\", Password = \"" + password + "\")");
				connectToWiFi();
			}
		} else if (status == WL_CONNECTED) {
			if (lastConnectionAttemptTime > 0) {
				logger::write("[Network] Connected to WiFi network");
				lastConnectionAttemptTime = 0;
			}
		} else {
			// WiFi not connected.
		}
	}

	bool isConnected() {
		return WiFi.status() == WL_CONNECTED;
	}

	bool platformIsDown() {
		bool down = (
			// Device has network connection.
			network::isConnected() &&
			// Both platform and ping-server are configured.
			platform::isConfigured() && pingServer::isConfigured() &&
			// Platform is NOT connected, but ping-server is connected.
			!platform::isConnected() && pingServer::isConnected()
		);
		if (
			down != platformDown &&
			(
				platformDownLastChangeTime == 0 ||
				millis() - platformDownLastChangeTime > platformDownDebounceTime
			)
		) {
			if (platformDownLastChangeTime > 0) {
				platformDown = down;
			}
			platformDownLastChangeTime = millis();
		}
		return platformDown;
	}

	std::string getUserAgent() {
		return firmwareName + " " + firmwareVersion;
	}
}
