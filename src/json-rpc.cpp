#include "json-rpc.h"

namespace {

	enum class State {
		uninitialized,
		waiting,
		active,
		timedOut
	};
	State state = State::uninitialized;

	const uint32_t maxInitialMessageWaitTime = 3000;// milliseconds

	// https://arduinojson.org/
	// https://www.jsonrpc.org/specification
	const char* jsonRpcVersion = "2.0";
	const size_t JSON_DOC_SIZE = 8192;

	std::string escapeLine(const std::string &line) {
		const unsigned int numBytes = line.size();
		const unsigned int remainderNumBytes = numBytes % 256;
		const unsigned int allocateNumBytes = remainderNumBytes > 0 ? (numBytes + 256) - remainderNumBytes : numBytes;
		DynamicJsonDocument docLine(allocateNumBytes + 256);
		docLine.set(line);
		String output;// Buffer the serialized JSON string.
		serializeJson(docLine, output);
		std::string escaped = std::string(output.c_str()).substr(1);// Remove first double-quote character.
		escaped.pop_back();// Remove last double-quote character.
		escaped += "\\n";// Escaped line-break character.
		return escaped;
	}

	class JsonRpcError : public std::exception {
		public:
			JsonRpcError(const std::string &t_message) noexcept;
			virtual ~JsonRpcError() = default;
			virtual const char* what() const noexcept override;
		private:
			std::string message;
	};

	JsonRpcError::JsonRpcError(const std::string &t_message) noexcept : message(t_message) {}

	const char* JsonRpcError::what() const noexcept {
		return this->message.c_str();
	}

	void sendToInterfaces(const JsonDocument& jsonDoc) {
		logger::write("Sending JSON-RPC message to serial interface");

		String jsonString;
		serializeJson(jsonDoc, jsonString);

		Serial.println(jsonString);

		bluetooth::sendMessage(jsonString.c_str());
	}

	void onMessage(const std::string &message) {
		std::string id;
		std::string method;
		try {
			if (message == "" || message.substr(0, 1) != "{") return;
			if (state == State::waiting) {
				logger::write("JSON-RPC serial interface active");
				state = State::active;
			}
			// !! Important !!
			// Keep the JsonDocument instance until done reading from the deserialized document; more info:
			// https://arduinojson.org/v6/issues/garbage-out/
			DynamicJsonDocument docIn(JSON_DOC_SIZE);
			const DeserializationError deserializationError = deserializeJson(docIn, message);
			if (deserializationError) {
				std::cerr << "deserializeJson error: " << deserializationError.c_str();
				throw JsonRpcError("Invalid JSON");
			}
			const JsonObject data = docIn.as<JsonObject>();
			if (!data.containsKey("jsonrpc")) {
				throw JsonRpcError("Missing required attribute: \"jsonrpc\"");
			}
			const std::string jsonrpc = data["jsonrpc"].as<const char*>();
			if (jsonrpc != "2.0") {
				throw JsonRpcError("Invalid attribute (\"jsonrpc\"): Only JSON-RPC version 2.0 is supported");
			}
			if (!data.containsKey("id")) {
				throw JsonRpcError("Missing required attribute: \"id\"");
			}
			id = data["id"].as<const char*>();
			method = data["method"].as<const char*>();
			if (method == "") {
				throw JsonRpcError("\"method\" is required");
			}
			logger::write("JSON-RPC command received: " + method);
			if (method == "restart") {
				logger::write("Restarting...");
				DynamicJsonDocument docOut(512);
				docOut["jsonrpc"] = jsonRpcVersion;
				docOut["id"] = id;
				docOut["result"] = true;
				sendToInterfaces(docOut);
				delay(500);// wait before restarting...
				esp_restart();
			} else if (method == "echo") {
				const std::string text = data["params"][0].as<const char*>();
				DynamicJsonDocument docOut(1024);
				docOut["jsonrpc"] = jsonRpcVersion;
				docOut["id"] = id;
				docOut["result"] = text;
				sendToInterfaces(docOut);
			} else if (method == "getinfo") {
				DynamicJsonDocument docOut(1024);
				docOut["jsonrpc"] = jsonRpcVersion;
				docOut["id"] = id;
				DynamicJsonDocument docInfo(768);
				docInfo["firmwareName"] = firmwareName;
				docInfo["firmwareCommitHash"] = firmwareCommitHash;
				docInfo["firmwareVersion"] = firmwareVersion;
				docInfo["spiffsInitialized"] = spiffs::isInitialized();
				docInfo["supportedLocales"] = i18n::getSupportedLocales();
				docOut["result"] = docInfo;
				sendToInterfaces(docOut);
			} else if (method == "getconfig") {
				DynamicJsonDocument docOut(JSON_DOC_SIZE);
				docOut["jsonrpc"] = jsonRpcVersion;
				docOut["id"] = id;
				DynamicJsonDocument requestedConfigs(JSON_DOC_SIZE);
				if (data.containsKey("params") && data["params"].is<JsonArray>() && data["params"].as<JsonArray>().size() > 0)) {
					const JsonArray params = data["params"].as<JsonArray>();
					for (const auto param : params) {
						const std::string key = param.as<const char*>();
						if (config::isConfigKey(key.c_str())) {
							requestedConfigs[key] = config::getString(key.c_str());
						}
					}
					docOut["result"] = requestedConfigs.as<JsonObject>();
				} else {
					docOut["result"] = config::getConfigurations();
				}

				sendToInterfaces(docOut);
			} else if (method == "setconfig") {
				logger::write("Saving configurations...");
				config::saveConfigurations(data["params"].as<JsonObject>());
				DynamicJsonDocument docOut(512);
				docOut["jsonrpc"] = jsonRpcVersion;
				docOut["id"] = id;
				docOut["result"] = true;
				sendToInterfaces(docOut);
			} else if (method == "getlogs") {
				if (!spiffs::isInitialized()) {
					throw JsonRpcError("SPIFFS file system not initialized. Reformat SPIFFS then try again.");
				}
				logger::write("Reading logs from SPIFFS file system...");
				Serial.print(std::string("{\"jsonrpc\":\"" + std::string(jsonRpcVersion) + "\",\"id\":\"" + std::string(id) + "\",\"result\":\"").c_str());
				for (int num = 3; num >= 0; num--) {
					const std::string logFilePath = logger::getLogFilePath(num);
					if (spiffs::fileExists(logFilePath.c_str())) {
						File file = SPIFFS.open(logFilePath.c_str(), FILE_READ);
						if (file) {
							while (file.available()) {
								Serial.print(escapeLine(file.readStringUntil('\n').c_str()).c_str());
							}
							file.close();
						}
					}
				}
				Serial.println(std::string("\"}").c_str());
				delay(1000);
			} else if (method == "deletelogs") {
				if (!spiffs::isInitialized()) {
					throw JsonRpcError("SPIFFS file system not initialized. Reformat SPIFFS then try again.");
				}
				logger::write("Deleting log files...");
				for (int num = 3; num >= 0; num--) {
					const std::string logFilePath = logger::getLogFilePath(num);
					if (spiffs::fileExists(logFilePath.c_str())) {
						spiffs::deleteFile(logFilePath.c_str());
					}
				}
				logger::write("Log files deleted");
				DynamicJsonDocument docOut(512);
				docOut["jsonrpc"] = jsonRpcVersion;
				docOut["id"] = id;
				docOut["result"] = true;
				sendToInterfaces(docOut);
			} else if (method == "spiffs_reformat") {
				logger::write("Reformatting SPIFFS file system...");
				if (!SPIFFS.format()) {
					throw JsonRpcError("Failed to reformat SPIFFS file system");
				}
				logger::write("SPIFFS file system reformatted");
				DynamicJsonDocument docOut(512);
				docOut["jsonrpc"] = jsonRpcVersion;
				docOut["id"] = id;
				docOut["result"] = true;
				sendToInterfaces(docOut);
			} else {
				throw JsonRpcError("Unknown method");
			}
		} catch (const JsonRpcError &e) {
			DynamicJsonDocument docOut(512);
			docOut["jsonrpc"] = jsonRpcVersion;
			if (id != "") {
				docOut["id"] = id;
			}
			docOut["error"] = e.what();
			sendToInterfaces(docOut);
			if (method != "") {
				logger::write("JSON-RPC Error (" + method + "): " + std::string(e.what()), "error");
			} else {
				logger::write("JSON-RPC Error: " + std::string(e.what()), "error");
			}
		} catch (const std::exception &e) {
			DynamicJsonDocument docOut(512);
			docOut["jsonrpc"] = jsonRpcVersion;
			if (id != "") {
				docOut["id"] = id;
			}
			docOut["error"] = "Unexpected error";
			sendToInterfaces(docOut);
			if (method != "") {
				logger::write("JSON-RPC Exception (" + method + "): " + std::string(e.what()), "error");
			} else {
				logger::write("JSON-RPC Exception: " + std::string(e.what()), "error");
			}
		}
	}

	void parseSerialInput() {
		if (Serial.available() > 0) {
			onMessage(std::string(Serial.readStringUntil('\n').c_str()));
		}
	}
}

namespace jsonRpc {

	void init() {}

	void loop() {
		if (state == State::uninitialized) {
			state = State::waiting;
			logger::write("Initializing JSON-RPC serial interface...");
		} else if (state == State::waiting) {
			if (millis() > maxInitialMessageWaitTime) {
				state = State::timedOut;
				logger::write("Timed-out while waiting for initial JSON-RPC message");
				delay(50);// Allow some time to finish writing the above log message.
			}
			parseSerialInput();
		} else if (state == State::active) {
			parseSerialInput();
		}
	}

	bool inUse() {
		// Consider JSON-RPC interface to be "in-use" when either:
		// A JSON-RPC message has been received or we are still waiting for an initial message.
		return state == State::waiting || state == State::active;
	}

	void onBleMessage(const std::string &message) {
		// Use onMessage to receive message from Bluetooth
		onMessage(message);
	}
}
