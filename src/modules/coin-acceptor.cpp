#include "modules/coin-acceptor.h"

namespace {

	std::vector<float> coinValues;
	float accumulatedValue = 0.00;

	float getCoinValue(const int &byteIn) {
		const int index = byteIn - 1;
		if (index >= 0 && index < coinValues.size()) {
			return coinValues[index];
		}
		return 0;
	}
}

namespace coinAcceptor {

	void init() {
		coinValues = config::getCoinValues();
		Serial2.begin(COIN_ACCEPTOR_DATA_RATE, SERIAL_8N1, COIN_ACCEPTOR_RX_PIN, 0);
		pinMode(COIN_ACCEPTOR_INHIBITING_PIN, OUTPUT);
		coinAcceptor::on();
	}

	void loop() {
		if (Serial2.available()) {
			byte byteIn = Serial2.read();
			if (byteIn > 0) {
				logger::write("Coin acceptor byte received: " + util::byteToString(byteIn));
				float coinValue = getCoinValue(byteIn);
				if (coinValue > 0) {
					logger::write("Coin inserted with value = " + util::floatToString(coinValue));
					accumulatedValue += coinValue;
				}
			}
		}
	}

	float getAccumulatedValue() {
		return accumulatedValue;
	}

	void reset() {
		accumulatedValue = 0.00;
	}

	void on() {
		logger::write("Switching coin acceptor ON");
		digitalWrite(COIN_ACCEPTOR_INHIBITING_PIN, HIGH);
	}

	void off() {
		logger::write("Switching coin acceptor OFF");
		digitalWrite(COIN_ACCEPTOR_INHIBITING_PIN, LOW);
	}
}
