#include "SPI.h"
#include "TFT_eSPI.h"
#include "logger.h"
#include "qrcode.h"
#include "util.h"
#include <sstream>
#include <string>

namespace display {
	void init();
	void setBackgroundColor(const std::string &hexColor);
	void setTextColor(const std::string &hexColor);
	void updateAmount(const float &amount, const std::string &fiatCurrency);
	void clearAmount();
	void renderQRCode(const std::string &dataStr);
	void clearQRCode();
}
