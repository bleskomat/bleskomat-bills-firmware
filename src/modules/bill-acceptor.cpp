#include "modules/bill-acceptor.h"

namespace {
	std::string fiatCurrency = "";
	float VALUE_ACCUMULATED = 0.00;

	// Mapping serial codes comming form NV10:
	// EUR {code, value} mappings
	std::map<int,int> eur{ {1, 5.0}, {2, 10.0}, {3, 20.0}, {4, 50.0}, {5, 100.0}, {6, 200.0} };
	// CZK {code, value} mappings
	std::map<int,int> czk{ {7, 100.0}, {8, 200.0}, {9, 500.0}, {10, 1000.0}, {11, 2000.0}, {12, 5000.0} };

	float getValueIncrement(byte byteIn) {
		logger::write(fiatCurrency);
		if (fiatCurrency == "EUR") {
			return eur[byteIn];
		}
		return czk[byteIn];
	}

	void incrementAccumulatedValue(byte byteIn) {
		VALUE_ACCUMULATED = VALUE_ACCUMULATED + getValueIncrement(byteIn);
	}
}

namespace billAcceptor {

	SoftwareSerial BillAcceptor(BILL_ACCEPTOR_RX_PIN, BILL_ACCEPTOR_TX_PIN); // RX, TX

	void init() {
		// set the data rate for the SoftwareSerial port
		BillAcceptor.begin(BILL_ACCEPTOR_DATA_RATE);
	}

	void loop() {

		if (BillAcceptor.available()) {
			byte byteIn = BillAcceptor.read();

			if (byteIn >= 1 && byteIn <= 12) {
				incrementAccumulatedValue(byteIn);
			}
		}
	}

	float getAccumulatedValue() {
		return VALUE_ACCUMULATED;
	}

	void setFiatCurrency(const std::string &str) {
		fiatCurrency = str;
	}

	void reset() {
		VALUE_ACCUMULATED = 0.00;
	}
}
