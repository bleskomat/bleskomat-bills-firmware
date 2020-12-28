#include "modules/bill-acceptor.h"

namespace {

	std::vector<float> billValues;
	float accumulatedValue = 0.00;

	float getBillValue(const int &byteIn) {
		const int index = byteIn - 1;
		if (index >= 0 && index < billValues.size()) {
			return billValues[index];
		}
		return 0;
	}
}

namespace billAcceptor {

	void init() {
		billValues = config::getBillValues();
		Serial1.begin(BILL_ACCEPTOR_DATA_RATE, SERIAL_8N1, BILL_ACCEPTOR_RX_PIN, BILL_ACCEPTOR_TX_PIN);
		billAcceptor::on();
	}

	void loop() {
		if (Serial1.available()) {
			byte byteIn = Serial1.read();
			if (byteIn > 0) {
				logger::write("Bill acceptor byte received: " + util::byteToString(byteIn));
				float billValue = getBillValue(byteIn);
				if (billValue > 0) {
					logger::write("Bill inserted with value = " + util::floatToString(billValue));
					accumulatedValue += billValue;
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
		logger::write("Switching bill acceptor ON");
		Serial1.write(BILL_ACCEPTOR_CODE_ENABLE_ALL);
	}

	void off() {
		logger::write("Switching bill acceptor OFF");
		Serial1.write(BILL_ACCEPTOR_CODE_DISABLE_ALL);
	}
}
