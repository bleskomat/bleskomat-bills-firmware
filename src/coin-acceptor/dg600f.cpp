#include "coin-acceptor/dg600f.h"

namespace {

	bool initialized = false;
	float accumulatedValue = 0.00;
	std::deque<int> buffer;
	std::vector<float> coinValues;
	unsigned short coinSignalPin;
	unsigned short coinInhibitPin;
	unsigned int coinBaudRate;

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
}

namespace coinAcceptor_dg600f {

	void init() {
		coinSignalPin = config::getUnsignedShort("coinSignalPin");
		coinInhibitPin = config::getUnsignedShort("coinInhibitPin");
		coinBaudRate = config::getUnsignedInt("coinBaudRate");
		coinValues = config::getFloatVector("coinValues");
	}

	void loop() {
		if (initialized) {
			while (Serial1.available()) {
				const int byteReceived = Serial1.read();
				if (byteReceived > 0 && byteReceived < 254) {
					buffer.push_back(byteReceived);
				}
			}
			parseBuffer();
		} else if (!(coinSignalPin > 0)) {
			logger::write("Cannot initialize coin acceptor: \"coinSignalPin\" not set");
		} else if (!(coinInhibitPin > 0)) {
			logger::write("Cannot initialize coin acceptor: \"coinInhibitPin\" not set");
		} else if (!(coinBaudRate > 0)) {
			logger::write("Cannot initialize coin acceptor: \"coinBaudRate\" not set");
		} else {
			logger::write("Initializing DG600F coin acceptor...");
			initialized = true;
			Serial1.begin(coinBaudRate, SERIAL_8E1, coinSignalPin, 0);
			pinMode(coinInhibitPin, OUTPUT);
			coinAcceptor_dg600f::disinhibit();
		}
	}

	float getAccumulatedValue() {
		return accumulatedValue;
	}

	void resetAccumulatedValue() {
		accumulatedValue = 0.00;
	}

	void inhibit() {
		digitalWrite(coinInhibitPin, LOW);
	}

	void disinhibit() {
		digitalWrite(coinInhibitPin, HIGH);
	}
}
