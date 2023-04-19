#include "bill-acceptor.h"

namespace {

	enum class State {
		uninitialized,
		initialized,
		failed
	};
	State state = State::uninitialized;

	// State:
	std::deque<int> buffer;
	float accumulatedValue = 0.00;
	float escrowValue = 0.00;
	float acceptEscrowValue = 0.00;
	bool inhibited = false;
	bool sentInitialCommands = false;
	unsigned long lastValidatorBusyTime = 0;

	// Configurations:
	std::vector<float> billValues;
	unsigned short billTxPin;
	unsigned short billRxPin;
	unsigned int billBaudRate;

	// Ping:
	unsigned long lastPingSentTime = 0;
	unsigned long lastPingReceivedTime = 0;
	unsigned int pingDelay = 1000;
	unsigned int pingTimeout = 7000;
	unsigned long lastReconnectTime = 0;
	unsigned int reconnectDelay = 5000;

	const std::map<const char*, const uint8_t> SIO_Codes = {
		{ "note_accepted_c1", 1 },
		{ "note_accepted_c2", 2 },
		{ "note_accepted_c3", 3 },
		{ "note_accepted_c4", 4 },
		{ "note_accepted_c5", 5 },
		{ "note_accepted_c6", 6 },
		{ "note_accepted_c7", 7 },
		{ "note_accepted_c8", 8 },
		{ "note_accepted_c9", 9 },
		{ "note_accepted_c10", 10 },
		{ "note_accepted_c11", 11 },
		{ "note_accepted_c12", 12 },
		{ "note_accepted_c13", 13 },
		{ "note_accepted_c14", 14 },
		{ "note_accepted_c15", 15 },
		{ "note_accepted_c16", 16 },
		{ "note_not_recognized", 20 },
		{ "mechanism_running_slow", 30 },
		{ "strimming_attempted", 40 },
		{ "note_rejected_channel_5_fraud", 50 },
		{ "stacker_full_or_jammed", 60 },
		{ "abort_during_escrow", 70 },
		{ "note_may_have_been_taken_to_clear_jam", 80 },
		{ "validator_busy", 120 },
		{ "validator_not_busy", 121 },
		{ "inhibit_c1", 131 },
		{ "inhibit_c2", 132 },
		{ "inhibit_c3", 133 },
		{ "inhibit_c4", 134 },
		{ "inhibit_c5", 135 },
		{ "inhibit_c6", 136 },
		{ "inhibit_c7", 137 },
		{ "inhibit_c8", 138 },
		{ "inhibit_c9", 139 },
		{ "inhibit_c10", 140 },
		{ "inhibit_c11", 141 },
		{ "inhibit_c12", 142 },
		{ "inhibit_c13", 143 },
		{ "inhibit_c14", 144 },
		{ "inhibit_c15", 145 },
		{ "inhibit_c16", 146 },
		{ "uninhibit_c1", 151 },
		{ "uninhibit_c2", 152 },
		{ "uninhibit_c3", 153 },
		{ "uninhibit_c4", 154 },
		{ "uninhibit_c5", 155 },
		{ "uninhibit_c6", 156 },
		{ "uninhibit_c7", 157 },
		{ "uninhibit_c8", 158 },
		{ "uninhibit_c9", 159 },
		{ "uninhibit_c10", 160 },
		{ "uninhibit_c11", 161 },
		{ "uninhibit_c12", 162 },
		{ "uninhibit_c13", 163 },
		{ "uninhibit_c14", 164 },
		{ "uninhibit_c15", 165 },
		{ "uninhibit_c16", 166 },
		{ "enable_escrow_mode", 170 },
		{ "disable_escrow_mode", 171 },
		{ "accept_escrow", 172 },
		{ "reject_escrow", 173 },
		{ "status", 182 },
		{ "enable_all", 184 },
		{ "disable_all", 185 },
		{ "disable_escrow_timeout", 190 },
		{ "enable_escrow_timeout", 191 },
		{ "request_firmware", 192 },
		{ "request_dataset", 193 },
		{ "command_error", 255 }
	};

	uint8_t getSIOCodeByte(const char* key) {
		if (SIO_Codes.count(key) > 0) {
			return SIO_Codes.at(key);
		}
		return 0;
	}

	void serialWriteSIOCode(const char* key) {
		if (state == State::initialized) {
			const uint8_t byteOut = getSIOCodeByte(key);
			if (byteOut > 0) {
				logger::write("Sending SIO code to bill acceptor: \"" + std::string(key) + "\"", "debug");
				Serial1.write(byteOut);
			}
		}
	}

	float getBillValue(const uint8_t &byteIn) {
		const uint8_t index = byteIn - 1;
		if (index >= 0 && index < billValues.size()) {
			return billValues[index];
		}
		return 0;
	}

	std::string getSIOCodeKey(const uint8_t &byteIn) {
		for (auto kv : SIO_Codes) {
			if (kv.second == byteIn) {
				return std::string(kv.first);
			}
		}
		return "";
	}

	bool validatorBusyRecently() {
		return lastValidatorBusyTime > 0 && millis() - lastValidatorBusyTime < 2000;
	}

	void parseBuffer() {
		while (buffer.size()) {
			const uint8_t byteIn = buffer.front();
			const std::string code = getSIOCodeKey(byteIn);
			logger::write("Bill acceptor code received: " + code, "debug");
			buffer.pop_front();
			if (code == "validator_busy") {
				lastValidatorBusyTime = millis();
			} else if (code == "enable_escrow_mode") {
				lastPingReceivedTime = millis();
			} else if (
				validatorBusyRecently()
				&& byteIn >= getSIOCodeByte("note_accepted_c1")
				&& byteIn <= getSIOCodeByte("note_accepted_c16")
			) {
				float billValue = getBillValue(byteIn);
				if (billValue > 0) {
					logger::write("Bill inserted with value = " + std::to_string(billValue));
					escrowValue += billValue;
				}
			} else if (code == "accept_escrow") {
				accumulatedValue += acceptEscrowValue;
				acceptEscrowValue = 0;
			} else if (code == "reject_escrow" || code == "abort_during_escrow") {
				acceptEscrowValue = 0;
			}
		}
	}

	void connect() {
		Serial1.begin(billBaudRate, SERIAL_8N1, billTxPin, billRxPin);
		sentInitialCommands = false;
	}

	void disconnect() {
		Serial1.end();
	}

	void reconnect() {
		logger::write("Attempting to reconnect to bill acceptor...");
		lastReconnectTime = millis();
		disconnect();
		connect();
	}

	void sendInitialCommands() {
		serialWriteSIOCode(inhibited ? "disable_all" : "enable_all");
		serialWriteSIOCode("enable_escrow_mode");
		serialWriteSIOCode("enable_escrow_timeout");
		sentInitialCommands = true;
	}
}

namespace billAcceptor {

	void init() {
		billTxPin = config::getUnsignedShort("billTxPin");
		billRxPin = config::getUnsignedShort("billRxPin");
		billBaudRate = config::getUnsignedInt("billBaudRate");
		billValues = config::getFloatVector("billValues");
	}

	void loop() {
		if (state == State::initialized) {
			if (!validatorBusyRecently() && millis() - lastPingSentTime > pingDelay) {
				serialWriteSIOCode("enable_escrow_mode");
				lastPingSentTime = millis();
			}
			while (Serial1.available()) {
				const uint8_t byteIn = Serial1.read();
				if (byteIn > 0) {
					buffer.push_back(byteIn);
				}
			}
			parseBuffer();
			if (billAcceptor::isConnected()) {
				if (!sentInitialCommands) {
					logger::write("Connection established with bill acceptor");
					sendInitialCommands();
				}
			} else if (millis() - lastReconnectTime > reconnectDelay) {
				// Not connected and enough time has passed to try to reconnect.
				reconnect();
			}
		} else if (state == State::uninitialized) {
			if (!(billRxPin > 0)) {
				logger::write("Cannot initialize bill acceptor: \"billRxPin\" not set", "warn");
				state = State::failed;
			} else if (!(billTxPin > 0)) {
				logger::write("Cannot initialize bill acceptor: \"billTxPin\" not set", "warn");
				state = State::failed;
			} else if (!(billBaudRate > 0)) {
				logger::write("Cannot initialize bill acceptor: \"billBaudRate\" not set", "warn");
				state = State::failed;
			} else {
				logger::write("Initializing bill acceptor...");
				connect();
				state = State::initialized;
			}
		}
	}

	void disinhibit() {
		inhibited = false;
		serialWriteSIOCode("enable_all");
	}

	void inhibit() {
		inhibited = true;
		serialWriteSIOCode("disable_all");
	}

	float getAccumulatedValue() {
		return accumulatedValue;
	}

	float getEscrowValue() {
		return escrowValue;
	}

	void resetAccumulatedValue() {
		accumulatedValue = 0.00;
	}

	void setAccumulatedValue(float value) {
		accumulatedValue = value;
	}

	void acceptEscrow() {
		serialWriteSIOCode("accept_escrow");
		acceptEscrowValue += escrowValue;
		escrowValue = 0;
	}

	void rejectEscrow() {
		serialWriteSIOCode("reject_escrow");
		escrowValue = 0;
	}

	bool isConnected() {
		return lastPingReceivedTime > 0 && millis() - lastPingReceivedTime < pingTimeout;
	}
}
