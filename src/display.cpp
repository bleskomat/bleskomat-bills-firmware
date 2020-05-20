#include "display.h"

namespace {

	TFT_eSPI tft = TFT_eSPI();
	const uint8_t baseFontCharWidth = 6;
	const uint8_t baseFontCharHeight = 8;
	const uint8_t amountTextSize = 2;
	int BG_COLOR;
	int TEXT_COLOR;
	int MARGIN = 16;

	uint8_t calculateAmountTextHeight(const bool &includeMargin = false) {
		uint8_t textHeight = baseFontCharHeight * amountTextSize;
		if (includeMargin) {
			textHeight = textHeight + (MARGIN * 2);
		}
		return textHeight;
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
				size = i + 1;
				break;
			}
		}
		return size;
	}

	float calculateQRCodeScale(const uint8_t &size) {
		const uint8_t maxWidth = tft.width() - (MARGIN * 2);
		const uint8_t maxHeight = tft.height() - (calculateAmountTextHeight(true) + MARGIN);
		return std::fmin(
			std::floor((maxWidth / size) * 100) / 100,
			std::floor((maxHeight / size) * 100) / 100
		);
	}
}

namespace display {

	void init() {
		tft.begin();
		tft.fillScreen(BG_COLOR);
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
		const uint8_t textWidth = baseFontCharWidth * amountTextSize * str.length();
		tft.setTextSize(amountTextSize);
		tft.setTextColor(TEXT_COLOR);
		tft.setCursor((tft.width() - textWidth) / 2, MARGIN);
		tft.println(text);
	}

	void clearAmount() {
		// Clear previous text by drawing a white rectangle over it.
		tft.fillRect(0, 0, tft.width(), calculateAmountTextHeight(true), BG_COLOR);
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
		const uint8_t offsetY = calculateAmountTextHeight(true);
		tft.fillRect(0, offsetY, tft.width(), tft.height() - offsetY, BG_COLOR);
	}
}
