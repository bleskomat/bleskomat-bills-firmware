#ifndef BLESKOMAT_DISPLAY_H
#define BLESKOMAT_DISPLAY_H

#include "logger.h"

#include <Arduino.h>
#include <qrcode.h>
#include <SPI.h>
#include <TFT_eSPI.h>

#include <iomanip>
#include <sstream>
#include <string>

	#ifndef BG_COLOR_HEX
		#define BG_COLOR_HEX "FFFFFF"
	#endif

	#ifndef TEXT_COLOR_HEX
		#define TEXT_COLOR_HEX "000000"
	#endif

namespace display {
	void init();
	void updateAmount(const float &amount, const std::string &fiatCurrency);
	void clearAmount();
	float getRenderedAmount();
	void renderQRCode(const std::string &dataStr);
	void clearQRCode();
	bool hasRenderedQRCode();
	unsigned long getTimeSinceRenderedQRCode();
}

#endif
