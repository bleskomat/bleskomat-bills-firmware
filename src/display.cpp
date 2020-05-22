#include "display.h"

namespace {

	TFT_eSPI tft = TFT_eSPI();
	const uint8_t MARGIN_X = 4;
	const uint8_t MARGIN_Y = 12;
	const uint8_t TEXT_MULTIPLIER = 1;
	const uint8_t TEXT_FONT = 2;
	int BG_COLOR;
	int TEXT_COLOR;

	uint8_t calculateAmountTextHeight() {
		return tft.fontHeight() * TEXT_MULTIPLIER;
	}

	std::string toUpperCase(std::string s) {
		std::transform(s.begin(), s.end(), s.begin(), [](unsigned char c){ return std::toupper(c); });
		return s;
	}

	int calculateQRCodeSize(const std::string &dataStr) {
		int size = 12;
		int sizes[17] = { 25, 47, 77, 114, 154, 195, 224, 279, 335, 395, 468, 535, 619, 667, 758, 854, 938 };
		int len = dataStr.length();
		for (int i = 0; i < 17; i++) {
			if (sizes[i] > len) {
				return i + 1;
			}
		}
		return size;
	}

	float calculateQRCodeScale(const uint8_t &size) {
		const uint8_t maxWidth = tft.width() - (MARGIN_X * 2);
		const uint8_t maxHeight = tft.height() - (calculateAmountTextHeight() + MARGIN_Y);
		return std::fmin(
			std::floor(maxWidth / size),
			std::floor(maxHeight / size)
		);
	}
}

namespace display {

	void init() {
		tft.begin();
		tft.fillScreen(BG_COLOR);
		tft.setTextFont(TEXT_FONT);
	}

	void setBackgroundColor(const std::string &hexColor) {
		BG_COLOR = util::hex_to_rgb565(hexColor);
	}

	void setTextColor(const std::string &hexColor) {
		TEXT_COLOR = util::hex_to_rgb565(hexColor);
	}

	void updateAmount(const float &amount, const std::string &fiatCurrency) {
		clearAmount();
		std::ostringstream fiat;
		fiat << amount << " " << fiatCurrency;
		const std::string str = fiat.str();
    	logger::write("Update amount: " + str);
		const char* text = str.c_str();
		tft.setTextSize(TEXT_MULTIPLIER);
		tft.setTextColor(TEXT_COLOR);
		const uint8_t textWidth = tft.textWidth(text);
		tft.setCursor((tft.width() - textWidth) / 2, MARGIN_Y);
		tft.println(text);
	}

	void clearAmount() {
		// Clear previous text by drawing a white rectangle over it.
		tft.fillRect(0, MARGIN_Y, tft.width(), calculateAmountTextHeight(), BG_COLOR);
	}

	void renderQRCode(const std::string &dataStr) {
		clearQRCode();
    	logger::write("Render QR code: " + dataStr);
		const char* data = toUpperCase(dataStr).c_str();
		const int size = calculateQRCodeSize(dataStr);
		QRCode qrcode;
		uint8_t qrcodeData[qrcode_getBufferSize(size)];
		qrcode_initText(&qrcode, qrcodeData, size, ECC_LOW, data);
		const float scale = calculateQRCodeScale(qrcode.size);
		uint8_t width = qrcode.size * scale;
		uint8_t offsetX = (tft.width() - width) / 2;
		uint8_t offsetY = tft.height() - (width + offsetX);
		for (uint8_t y = 0; y < qrcode.size; y++) {
			for (uint8_t x = 0; x < qrcode.size; x++) {
				int color = qrcode_getModule(&qrcode, x, y) ? TEXT_COLOR : BG_COLOR;
				tft.fillRect(offsetX + scale*x, offsetY + scale*y, scale, scale, color);
			}
		}
	}

	void clearQRCode() {
    	logger::write("Clear QR code");
		const uint8_t offsetY = calculateAmountTextHeight() + MARGIN_Y;
		tft.fillRect(0, offsetY, tft.width(), tft.height() - offsetY, BG_COLOR);
	}
}
