#include "modules/bill-acceptor.h"

namespace {
	std::string currentFiatCurrency = "";
	SoftwareSerial billAcceptorSerial(BILL_ACCEPTOR_RX_PIN, BILL_ACCEPTOR_TX_PIN); // RX, TX
	unsigned int valueAccumulated = 0;
	bool billWasInserted = false;
	unsigned long lastInsertedTime = 0;
	// Mapping of serial codes coming from NV10:
	typedef std::map <byte, unsigned int> ByteToValueMap;
	typedef std::map <std::string, ByteToValueMap> CurrencyValuesNestedMap;
	CurrencyValuesNestedMap values{
		{
			"EUR", {
				{1, 5},
				{2, 10},
				{3, 20},
				{4, 50},
				{5, 100},
				{6, 200}
			}
		},
		{
			"CZK", {
				{7, 100},
				{8, 200},
				{9, 500},
				{10, 1000},
				{11, 2000},
				{12, 5000}
			}
		}
	};

	unsigned int getValue(std::string fiatCurrency, byte byteIn) {
		CurrencyValuesNestedMap::iterator it = values.find(fiatCurrency);
		if (it != values.end()) {
			ByteToValueMap &innerMap = it->second;
			ByteToValueMap::iterator innerIt = innerMap.find(byteIn);
			if (innerIt != innerMap.end()) {
				return innerIt->second;
			}
		}
		return 0;
	}
}

namespace billAcceptor {

	void init() {
		// Set the data rate for the SoftwareSerial port.
		billAcceptorSerial.begin(BILL_ACCEPTOR_DATA_RATE);
	}

	void loop() {
		billWasInserted = false;
		if (billAcceptorSerial.available()) {
			byte byteIn = billAcceptorSerial.read();
			unsigned int valueInserted = getValue(currentFiatCurrency, byteIn);
			if (valueInserted > 0) {
				logger::write("Bill inserted: " + util::toString(valueInserted) + " " + currentFiatCurrency);
				valueAccumulated = valueAccumulated + valueInserted;
				lastInsertedTime = millis();
				billWasInserted = true;
			} else {
				logger::write("Unknown byte received from bill acceptor: byte = " + util::toString(byteIn) + ", fiatCurrency = " + currentFiatCurrency);
			}
		}
	}

	bool billInserted() {
		return billWasInserted;
	}

	unsigned int getAccumulatedValue() {
		return valueAccumulated;
	}

	void setFiatCurrency(const std::string &fiatCurrency) {
		currentFiatCurrency = fiatCurrency;
	}

	void reset() {
		valueAccumulated = 0;
		lastInsertedTime = 0;
		billWasInserted = false;
	}
}
