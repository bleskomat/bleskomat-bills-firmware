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

#ifndef BLESKOMAT_MODULES_COIN_ACCEPTOR_H
#define BLESKOMAT_MODULES_COIN_ACCEPTOR_H

#include "logger.h"

#include <Arduino.h>
#include <SoftwareSerial.h>

#include <map>

#ifndef COIN_ACCEPTOR_RX_PIN
	#define COIN_ACCEPTOR_RX_PIN 16
#endif

#ifndef COIN_ACCEPTOR_INHIBITING_PIN
	#define COIN_ACCEPTOR_INHIBITING_PIN 21
#endif


// 9600 or 4800
#ifndef COIN_ACCEPTOR_DATA_RATE
	#define COIN_ACCEPTOR_DATA_RATE 4800
#endif

#ifndef COIN_RELAY_PIN
	#define COIN_RELAY_PIN 2
#endif

namespace coinAcceptor {
	void init();
	void loop();
	bool coinInserted();
	float getAccumulatedValue();
	void setFiatCurrency(const std::string &fiatCurrency);
	void reset();
	void on();
	void off();
}

#endif
