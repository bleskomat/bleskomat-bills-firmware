#include "modules/bill-acceptor.h"

namespace {

	std::vector<float> billValues;
	std::deque<int> buffer;
	float accumulatedValue = 0.00;
	float escrowValue = 0.00;

	float getBillValue(const int &byteIn) {
		const int index = byteIn - 1;
		if (index >= 0 && index < billValues.size()) {
			return billValues[index];
		}
		return 0;
	}

	void parseBuffer() {
		while (buffer.size() >= 3) {
			const int byte1 = buffer.front();
			buffer.pop_front();
			if (byte1 == BILL_ACCEPTOR_CODE_IS_BUSY) {
				const int byte2 = buffer.front();
				buffer.pop_front();
				if (byte2 == BILL_ACCEPTOR_CODE_NOT_BUSY) {
					// The next byte should be the bill value reference.
					const int byte3 = buffer.front();
					buffer.pop_front();
					float billValue = getBillValue(byte3);
					if (billValue > 0) {
						logger::write("Bill inserted with value = " + std::to_string(billValue));
						escrowValue += billValue;
					}
				}
			}
		}
	}
}

namespace billAcceptor {

	void init() {
		billValues = config::getBillValues();
		Serial1.begin(BILL_ACCEPTOR_DATA_RATE, SERIAL_8N1, BILL_ACCEPTOR_RX_PIN, BILL_ACCEPTOR_TX_PIN);
		billAcceptor::on();
		billAcceptor::enableEscrowMode();
	}

	void loop() {
		while (Serial1.available()) {
			byte byteIn = Serial1.read();
			if (byteIn > 0) {
				logger::write("Bill acceptor byte received: " + std::to_string(byteIn));
				buffer.push_back(byteIn);
			}
		}
		parseBuffer();
	}

	float getAccumulatedValue() {
		return accumulatedValue;
	}

	float getEscrowValue() {
		return escrowValue;
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

	void enableEscrowMode() {
		logger::write("Enabling escrow mode in bill acceptor");
		Serial1.write(BILL_ACCEPTOR_CODE_ENABLE_ESCROW);
	}

	void acceptEscrow() {
		logger::write("Accepting escrow in bill acceptor");
		accumulatedValue += escrowValue;
		Serial1.write(BILL_ACCEPTOR_CODE_ACCEPT_ESCROW);
		billAcceptor::clearEscrowValue();
	}

	void rejectEscrow() {
		logger::write("Rejecting escrow in bill acceptor");
		Serial1.write(BILL_ACCEPTOR_CODE_REJECT_ESCROW);
		billAcceptor::clearEscrowValue();
	}

	void clearEscrowValue() {
		logger::write("Clearing escrow value in bill acceptor");
		escrowValue = 0.0;
	}
}
