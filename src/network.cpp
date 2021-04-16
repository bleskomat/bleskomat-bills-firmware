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

#ifdef FETCH_EXCHANGE_RATE
	float exchange_rate;
	bool has_exchange_rate = false;
	unsigned long last_fetched_exchange_rate = 0;
	const unsigned long exchange_rate_update_interval = 5*60*1000; // 5 minutes

	// root Certification Authority certificate -- for exchange rate , expires 12/05/2025
	const char* cloudflare_root_ca = \
		"-----BEGIN CERTIFICATE-----\n" \
		"MIIDdzCCAl+gAwIBAgIEAgAAuTANBgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJJ\n" \
		"RTESMBAGA1UEChMJQmFsdGltb3JlMRMwEQYDVQQLEwpDeWJlclRydXN0MSIwIAYD\n" \
		"VQQDExlCYWx0aW1vcmUgQ3liZXJUcnVzdCBSb290MB4XDTAwMDUxMjE4NDYwMFoX\n" \
		"DTI1MDUxMjIzNTkwMFowWjELMAkGA1UEBhMCSUUxEjAQBgNVBAoTCUJhbHRpbW9y\n" \
		"ZTETMBEGA1UECxMKQ3liZXJUcnVzdDEiMCAGA1UEAxMZQmFsdGltb3JlIEN5YmVy\n" \
		"VHJ1c3QgUm9vdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKMEuyKr\n" \
		"mD1X6CZymrV51Cni4eiVgLGw41uOKymaZN+hXe2wCQVt2yguzmKiYv60iNoS6zjr\n" \
		"IZ3AQSsBUnuId9Mcj8e6uYi1agnnc+gRQKfRzMpijS3ljwumUNKoUMMo6vWrJYeK\n" \
		"mpYcqWe4PwzV9/lSEy/CG9VwcPCPwBLKBsua4dnKM3p31vjsufFoREJIE9LAwqSu\n" \
		"XmD+tqYF/LTdB1kC1FkYmGP1pWPgkAx9XbIGevOF6uvUA65ehD5f/xXtabz5OTZy\n" \
		"dc93Uk3zyZAsuT3lySNTPx8kmCFcB5kpvcY67Oduhjprl3RjM71oGDHweI12v/ye\n" \
		"jl0qhqdNkNwnGjkCAwEAAaNFMEMwHQYDVR0OBBYEFOWdWTCCR1jMrPoIVDaGezq1\n" \
		"BE3wMBIGA1UdEwEB/wQIMAYBAf8CAQMwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3\n" \
		"DQEBBQUAA4IBAQCFDF2O5G9RaEIFoN27TyclhAO992T9Ldcw46QQF+vaKSm2eT92\n" \
		"9hkTI7gQCvlYpNRhcL0EYWoSihfVCr3FvDB81ukMJY2GQE/szKN+OMY3EU/t3Wgx\n" \
		"jkzSswF07r51XgdIGn9w/xZchMB5hbgF/X++ZRGjD8ACtPhSNzkE1akxehi/oCr0\n" \
		"Epn3o0WC4zxe9Z2etciefC7IpJ5OCBRLbf1wbWsaY71k5h+3zvDyny67G7fyUIhz\n" \
		"ksLi4xaNmjICq44Y3ekQEe5+NauQrz4wlHrQMz2nZQ/1/I6eYs9HRCwBXbsdtTLS\n" \
		"R9I4LtD+gdwyah617jzV/OeBHRnDJELqYzmp\n" \
		"-----END CERTIFICATE-----\n";
#endif


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
#ifdef FETCH_EXCHANGE_RATE
		if (isConnected() && ( ! has_exchange_rate || (millis() - last_fetched_exchange_rate) > exchange_rate_update_interval) ){
				network::fetchExchangeRate(config::get("fiatCurrency"));
		}
#endif
	}

	void connect() {
		const BleskomatWifiConfig wifiConfig = config::getWifiConfig();
		tryConnectWithConfig(wifiConfig);
	}

#ifdef FETCH_EXCHANGE_RATE
	void fetchExchangeRate(std::string fiatCurrency) {

		String currency = String(fiatCurrency.c_str());
		logger::write("Fetching the exchange rate");

		WiFiClientSecure client;
		client.setCACert(cloudflare_root_ca);
		if (!client.connect("api.bitfinex.com", 443)) {
			Serial.println("failed to api.bitfinex.com");
			return;
		}

		String url = "/v1/pubticker/BTC" + currency;
		client.print(String("GET ") + url + " HTTP/1.1\r\n" +
					 "Host: api.bitfinex.com\r\n" +
					 "User-Agent: ESP32\r\n" +
					 "Connection: close\r\n\r\n");

		// this parts reads the header
		while (client.connected()) {
			String line = client.readStringUntil('\n');
			if (line == "\r") {
				break;
			}
		}
		// here it reads the body and process Json
		String line = client.readStringUntil('\n');
		const size_t capacity = 169*JSON_OBJECT_SIZE(1) + JSON_OBJECT_SIZE(168) + 3800;
		DynamicJsonDocument doc(capacity);
		deserializeJson(doc, line);
		// Serial.println(line);

		exchange_rate = doc["mid"]; 

		if (exchange_rate > 0.0) {
			logger::write("Exchange rate is: " + std::to_string(exchange_rate));
			has_exchange_rate = true;
			last_fetched_exchange_rate = millis();
		} else {
			logger::write("exchange rate has a weird value");
		}
	}
#endif // FETCH_EXCHANGE_RATE

	bool isConnected() {
		return WiFi.status() == WL_CONNECTED;
	}
}
