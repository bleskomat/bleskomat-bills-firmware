#include "network.h"

// WiFi library usage examples:
// https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFi/examples

// How to listen for various WiFi-related events:
// https://github.com/espressif/arduino-esp32/blob/master/libraries/WiFi/examples/WiFiClientEvents/WiFiClientEvents.ino

namespace {

	unsigned long lastConnectionAttemptTime = 0;
	unsigned long connectionAttemptDelay = 10000;// milliseconds
	unsigned long lastStatusCheckTime = 0;
	unsigned long statusCheckDelay = 300000;// milliseconds

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

	std::map <std::string, std::string> getHostFromUrl(const std::string &t_url) {
		std::string domain = t_url;
		const std::string protocolDelimiter = "://";
		const std::size_t protocolDelimiterPos = domain.find(protocolDelimiter);
		if (protocolDelimiterPos != std::string::npos) {
			domain = domain.substr(protocolDelimiterPos + protocolDelimiter.size());
		}
		const std::string hostDelimiter = "/";
		const std::size_t hostDelimiterPos = domain.find(hostDelimiter);
		if (hostDelimiterPos != std::string::npos) {
			domain = domain.substr(0, hostDelimiterPos);
		}
		std::string port = "443";
		const std::string portDelimiter = ":";
		const std::size_t portDelimiterPos = domain.find(portDelimiter);
		if (portDelimiterPos != std::string::npos) {
			port = domain.substr(portDelimiterPos + portDelimiter.size());
			domain = domain.substr(0, portDelimiterPos - portDelimiter.size());
		}
		std::map <std::string, std::string> host;
		host["domain"] = domain;
		host["port"] = port;
		return host;
	}

	typedef std::map <std::string, std::string> HttpHeaders;

	struct HttpResponse {
		HttpHeaders headers;
		int status;
		std::string body;
	};

	struct HttpRequest {
		std::string method = "GET";
		std::string url;
		HttpHeaders headers;
		std::string body;
	};

	HttpResponse doHttpRequest(const HttpRequest &request) {
		HttpResponse response;
		try {
			// See:
			// https://github.com/espressif/arduino-esp32/blob/master/libraries/WiFiClientSecure/examples/WiFiClientSecure/WiFiClientSecure.ino
			WiFiClientSecure client;
			const std::string webCACert = config::get("webCACert");
			const std::map <std::string, std::string> host = getHostFromUrl(request.url);
			const char* server = host.at("domain").c_str();
			const int port = std::stoi(host.at("port"));
			const std::string method = util::toUpperCase(request.method);
			client.setCACert(webCACert.c_str());
			if (!client.connect(server, port)) {
				response.status = 0;
			} else {
				// Client connected.
				// Send HTTP request headers and body (if any).
				client.println(std::string(method + " " + request.url + " HTTP/1.1").c_str());
				if (request.headers.find("Host") == request.headers.end()) {
					client.println(std::string("Host: " + std::string(server)).c_str());
				}
				for (auto const &it : request.headers) {
					std::string name = it.first;
					std::string value = it.second;
					client.println(std::string(name + ": " + value).c_str());
				}
				if (request.headers.find("User-Agent") == request.headers.end()) {
					client.println("User-Agent: Bleskomat-ESP32");
				}
				if (request.headers.find("Connection") == request.headers.end()) {
					client.println("Connection: close");
				}
				if (request.body != "") {
					client.println(request.body.c_str());
				}
				// Send final, empty line.
				client.println();
				// Wait for response then begin by parsing response headers.
				const std::string headerDelimiter = ": ";
				while (client.connected()) {
					std::string line = client.readStringUntil('\n').c_str();
					std::string statusDelimiter = "HTTP/1.1 ";
					if (line.substr(0, std::string(statusDelimiter).size()) == statusDelimiter) {
						// First line of HTTP headers.
						// Get the status code.
						response.status = std::stoi(line.substr(statusDelimiter.size(), 3));
					}
					std::size_t headerDelimiterPos = line.find(headerDelimiter);
					if (headerDelimiterPos != std::string::npos) {
						std::string name = line.substr(0, headerDelimiterPos);
						std::string value = line.substr(headerDelimiterPos + headerDelimiter.size());
						response.headers[name] = value;
					}
					if (line == "\r") {
						// End of HTTP headers.
						break;
					}
				}
				// Read the response body.
				std::ostringstream stream;
				while (client.available()) {
					stream << client.readStringUntil('\r').c_str();
				}
				response.body = stream.str();
				logger::write(response.body);
				client.stop();
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
		return response;
	}

	void doStatusCheck() {
		try {
			logger::write("Performing remote status check");
			HttpRequest request;
			Lnurl::Query query;
			request.url = util::createSignedUrl(
				config::get("webUrl") + "/api/v1/device/status",
				query
			);
			HttpResponse response = doHttpRequest(request);
			for (auto const &it : response.headers) {
				std::string name = it.first;
				std::string value = it.second;
			}
			if (response.status == 200) {
				config::ValuesMap valuesMap = config::parseConfigLines(response.body);
				config::saveConfigurations(valuesMap);
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
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
			if ((lastStatusCheckTime == 0 || millis() - lastStatusCheckTime >= statusCheckDelay)) {
				lastStatusCheckTime = millis();
				if (config::get("webUrl") != "" && config::get("webCACert") != "") {
					doStatusCheck();
				}
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
}
