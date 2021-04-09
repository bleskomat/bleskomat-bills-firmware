#include "modules/coin-acceptor.h"

namespace {

	std::vector<float> coinValues;
	float maxCoinValue = 0.00;
	float accumulatedValue = 0.00;
	std::deque<int> buffer;
	bool inhibited = false;

	float getCoinValue(const int &byteIn) {
		const int index = byteIn - 1;
		if (index >= 0 && index < coinValues.size()) {
			return coinValues[index];
		}
		return 0;
	}

	void parseBuffer() {
		while (buffer.size() >= 3) {
			const int byte1 = buffer.front();
			buffer.pop_front();
			if (byte1 == 0xAA) {
				// "Title" byte found.
				// The next byte should be the coin value reference.
				const int byte2 = buffer.front();
				buffer.pop_front();
				const float coinValue = getCoinValue(byte2);
				if (coinValue > 0) {
					// Coin value found.
					// The next byte is the XOR of the previous two bytes.
					const int byte3 = buffer.front();
					buffer.pop_front();
					if (byte3 == (byte1 ^ byte2)) {
						logger::write("Coin inserted with value = " + std::to_string(coinValue));
						accumulatedValue += coinValue;
					}
				}
			}
		}
	}

	float findMaxValueInFloatVector(const std::vector<float> &floatVector) {
		float maxValue = 0;
		for (int index = 0; index < floatVector.size(); index++) {
			float value = floatVector.at(index);
			if (value > maxValue) {
				maxValue = value;
			}
		}
		return maxValue;
	}
}

namespace coinAcceptor {

	void init() {
		coinValues = config::getCoinValues();
		maxCoinValue = findMaxValueInFloatVector(coinValues);
		Serial2.begin(COIN_ACCEPTOR_DATA_RATE, SERIAL_8N1, COIN_ACCEPTOR_RX_PIN, 0);
		pinMode(COIN_ACCEPTOR_INHIBITING_PIN, OUTPUT);
		coinAcceptor::on();
	}

	void loop() {
		while (Serial2.available()) {
			const int byteReceived = Serial2.read();
			if (byteReceived > 0 && byteReceived < 254) {
				logger::write("Coin acceptor byte received: " + std::to_string(byteReceived));
				buffer.push_back(byteReceived);
			}
		}
		parseBuffer();
	}

	float getAccumulatedValue() {
		return accumulatedValue;
	}

	float getMaxCoinValue() {
		return maxCoinValue;
	}

	void reset() {
		accumulatedValue = 0.00;
	}

	bool isOff() {
		return inhibited;
	}

	bool isOn() {
		return !inhibited;
	}

	void on() {
		logger::write("Switching coin acceptor ON");
		digitalWrite(COIN_ACCEPTOR_INHIBITING_PIN, HIGH);
		inhibited = false;
	}

	void off() {
		logger::write("Switching coin acceptor OFF");
		digitalWrite(COIN_ACCEPTOR_INHIBITING_PIN, LOW);
		inhibited = true;
	}
}
