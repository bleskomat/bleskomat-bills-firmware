#include "wifi-access-point.h"

namespace {

	bool available = false;
	unsigned long startTime = 0;
	BleskomatAccessPointConfig accessPoint;

	const byte DNS_PORT = 53;
	const std::string accessPointUrl = "http://bleskomat";
	const IPAddress APIP(8, 8, 4, 4);// The default android DNS

	// DNSServer implementation for ESP32:
	// https://github.com/espressif/arduino-esp32/tree/master/libraries/DNSServer
	DNSServer dnsServer;

	// WebServer implementation for ESP32:
	// https://github.com/espressif/arduino-esp32/tree/master/libraries/WebServer
	WebServer webServer(80);

	std::string generateRandomPassword() {
		return util::generateRandomWords(3);
	}

	const char* preparePageHtml(
		const std::string &title,
		const std::string &description,
		const std::string &bodyHtml = ""
	) {
		std::ostringstream ss;
		ss << "<!DOCTYPE html><html lang='en'><head><meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>";
		ss << "<title>Bleskomat - " << title << "</title>";
		ss << "</head>";
		ss << "<body>";
		ss << "<nav>";
		ss << "<a href='/configure'>Configure</a>";
		ss << "<a href='/transaction'>Transaction Lookup</a>";
		ss << "<a href='/logs'>View Logs</a>";
		ss << "<a href='/about'>About</a>";
		ss << "</nav>";
		ss << "<h1>" << title << "</h1>";
		if (description != "") {
			ss << "<p>" << description << "</p>";
		}
		ss << bodyHtml;
		ss << "</body>";
		ss << "</html>";
		return ss.str().c_str();
	}

	typedef const char* RouteUri;
	typedef WebServer::THandlerFunction RouteHandler;
	typedef std::pair<RouteUri, HTTPMethod> Route;
	typedef std::map<Route, RouteHandler> RouteDefinitions;

	RouteDefinitions routes = {
		{
			{ "/", HTTP_GET }, []() {
				webServer.send(200, "text/html", preparePageHtml(
					"Web Interface",
					"Welcome to the Bleskomat web interface!"
				));
			},
		},
		{
			{ "/about", HTTP_GET }, []() {
				webServer.send(200, "text/html", preparePageHtml(
					"About",
					"Information about this Bleskomat are shown here.",
					"!!!"
				));
			}
		},
		{
			{ "/configure", HTTP_GET }, []() {
				webServer.send(200, "text/html", preparePageHtml(
					"Configure",
					"Use this page to change the Bleskomat's configuration options.",
					"!!!"
				));
			},
		},
		{
			{ "/logs", HTTP_GET }, []() {
				webServer.send(200, "text/html", preparePageHtml(
					"Logs",
					"The Bleskomat's logs are shown here.",
					"!!!"
				));
			}
		},
		{
			{ "/transaction", HTTP_GET }, []() {
				webServer.send(200, "text/html", preparePageHtml(
					"Transaction Lookup",
					"Find individual transactions by their reference code.",
					"!!!"
				));
			},
		}
	};
}

namespace wifiAccessPoint {

	void loop() {
		if (available) {
			dnsServer.processNextRequest();
			webServer.handleClient();
		}
	}

	void start() {
		if (!available) {
			logger::write("Starting WiFi access point...");
			accessPoint = config::getAccessPointConfig();
			if (accessPoint.password == "") {
				accessPoint.password = generateRandomPassword();
			}
			WiFi.mode(WIFI_OFF);
			WiFi.mode(WIFI_AP);
			WiFi.softAP(accessPoint.ssid.c_str(), accessPoint.password.c_str());
			WiFi.softAPConfig(APIP, APIP, IPAddress(255, 255, 255, 0));
			// Set "*" as domain name, to make DNS server respond with AP IP address for all requests.
			dnsServer.start(DNS_PORT, "*", APIP);
			webServer.begin();
			for (auto const &it : routes) {
				Route route = it.first;
				RouteHandler fn = it.second;
				RouteUri uri = route.first;
				HTTPMethod method = route.second;
				webServer.on(uri, method, fn);
			}
			webServer.onNotFound([]() {
				webServer.send(404, "text/html", preparePageHtml("Not Found", "", "<p>Page not found</p>"));
			});
			available = true;
			startTime = millis();
			logger::write("Access point ready");
			logger::write("SSID: " + accessPoint.ssid);
			logger::write("Password: " + accessPoint.password);
			logger::write("Interface URL: " + wifiAccessPoint::getURL());
		}
	}

	void stop() {
		if (available) {
			logger::write("Stopping WiFi access point...");
			WiFi.softAPdisconnect(true);
			dnsServer.stop();
			webServer.stop();
			available = false;
			startTime = 0;
		}
	}

	bool isAvailable() {
		return available;
	}

	unsigned long getTimeAvailable() {
		if (available) {
			return millis() - startTime;
		}
		return 0;
	}

	bool hasClientsConnected() {
		return wifiAccessPoint::getTimeAvailable() > 3000 && WiFi.softAPgetStationNum() > 0;
	}

	std::string getSSID() {
		return accessPoint.ssid;
	}

	std::string getPassword() {
		return accessPoint.password;
	}

	std::string getConfigurationString() {
		// See zxing project for details:
		// https://github.com/zxing/zxing/blob/2e2b5ba757b6cbc2fdeaaa0ed6dcdd794abb5b2e/core/src/main/java/com/google/zxing/client/result/WifiResultParser.java
		return "WIFI:T:WPA2;S:" + accessPoint.ssid + ";P:" + accessPoint.password + ";;";
	}

	std::string getURL() {
		return accessPointUrl;
	}
}
