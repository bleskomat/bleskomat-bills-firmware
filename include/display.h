#include "SPI.h"
#include "TFT_eSPI.h"
#include "logger.h"
#include "qrcode.h"
#include "util.h"
#include <sstream>
#include <string>
#include <Arduino.h>

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
