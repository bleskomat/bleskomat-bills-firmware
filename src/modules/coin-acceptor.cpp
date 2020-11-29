/*
	Copyright (C) 2020 Samotari (Charles Hill, Carlos Garcia Ortiz)

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include "modules/coin-acceptor.h"

namespace {
	std::string fiatCurrency = "";
	SoftwareSerial coinAcceptorSerial(COIN_ACCEPTOR_RX_PIN, 17); // RX
	float VALUE_ACCUMULATED = 0.00;
	// uint8_t LAST_PIN_READ;
	// unsigned long LAST_PIN_READ_TIME = 0;
	bool COIN_INSERTED = false;
	unsigned long LAST_INSERTED_TIME = 0;

	typedef std::map <byte, unsigned int> ByteToValueMap;
	// typedef std::map <std::string, ByteToValueMap> CurrencyValuesNestedMap;
	// CurrencyValuesNestedMap values{
	// 	{
	// 		"EUR", {
	// 			{1, 5},
	// 			{2, 10},
	// 			{3, 20},
	// 			{4, },
	// 			{5, 1.00},
	// 			{6, 2.00}
	// 		}
	// 	},
	// 	{
	// 		"CZK", {
	// 			{1, 1},
	// 			{2, 2},
	// 			{3, 5},
	// 			{4, 10},
	// 			{5, 20},
	// 			{6, 50}
	// 		}
	// 	}
	// };

	float getValueIncrement(byte byteIn) {
		if (fiatCurrency == "EUR") {
			return 0.05;
		}
		return 1.0;
	}

	void incrementAccumulatedValue(byte byteIn) {
		VALUE_ACCUMULATED = VALUE_ACCUMULATED + getValueIncrement(byteIn);
	}
}

namespace coinAcceptor {

	void init() {
		logger::write("coinAcceptor::init()");
		printf("COIN_ACCEPTOR_DATA_RATE: %d\n", COIN_ACCEPTOR_DATA_RATE);
		coinAcceptorSerial.begin(COIN_ACCEPTOR_DATA_RATE);
		pinMode(COIN_ACCEPTOR_INHIBITING_PIN, OUTPUT);
		digitalWrite(COIN_ACCEPTOR_INHIBITING_PIN, HIGH);
	}

	void loop() {
		COIN_INSERTED = false;
		byte byteIn = coinAcceptorSerial.read();
		if (byteIn != 255) {\
			printf("byteIn: %d\n", byteIn);
		}
		if (coinAcceptorSerial.available()) {
			logger::write("COIN IS AVALABLE");
			byte byteIn = coinAcceptorSerial.read();
			printf("byteIn: %d\n", byteIn);
			if (byteIn >= 1) {
				logger::write("Coin inserted");
				incrementAccumulatedValue(byteIn);
				LAST_INSERTED_TIME = millis();
				COIN_INSERTED = true;
			}
		}
	}

	bool coinInserted() {
		return COIN_INSERTED;
	}

	float getAccumulatedValue() {
		return VALUE_ACCUMULATED;
	}

	void setFiatCurrency(const std::string &str) {
		fiatCurrency = str;
	}

	void reset() {
		COIN_INSERTED = false;
		VALUE_ACCUMULATED = 0.00;
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
