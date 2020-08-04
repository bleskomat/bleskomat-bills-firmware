#include "modules/bill-acceptor.h"

namespace {
	std::string fiatCurrency = "";
	SoftwareSerial billAcceptorSerial(BILL_ACCEPTOR_RX_PIN, BILL_ACCEPTOR_TX_PIN); // RX, TX
	float VALUE_ACCUMULATED = 0.00;
	bool BILL_INSERTED = false;
	unsigned long LAST_INSERTED_TIME = 0;
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

	void init() {
		// set the data rate for the SoftwareSerial port
		logger::write("billAcceptor::init()");
		printf("BILL_ACCEPTOR_DATA_RATE: %d\n", BILL_ACCEPTOR_DATA_RATE);
		billAcceptorSerial.begin(BILL_ACCEPTOR_DATA_RATE);
	}

	void loop() {
		BILL_INSERTED = false;
		if (billAcceptorSerial.available()) {
			byte byteIn = billAcceptorSerial.read();
			if (byteIn >= 1 && byteIn <= 12) {
				logger::write("Bill inserted");
				incrementAccumulatedValue(byteIn);
				LAST_INSERTED_TIME = millis();
				BILL_INSERTED = true;
			}
		}
	}

	bool billInserted() {
		return BILL_INSERTED;
	}

	float getAccumulatedValue() {
		return VALUE_ACCUMULATED;
	}

	void setFiatCurrency(const std::string &str) {
		fiatCurrency = str;
	}

	void reset() {
		BILL_INSERTED = false;
		LAST_INSERTED_TIME = 0;
		VALUE_ACCUMULATED = 0.00;
	}
}
