#include "display.h"

namespace {

	TFT_eSPI tft = TFT_eSPI();
	const uint8_t MARGIN_X = 4;
	const uint8_t MARGIN_Y = 12;
	const uint8_t TEXT_FONT = 2;
	const uint8_t TEXT_MULTIPLIER_AMOUNT = 1;
	const uint8_t TEXT_MULTIPLIER_TIMER = 3;
	int BG_COLOR;
	int TEXT_COLOR;
	unsigned long LAST_RENDERED_QRCODE_TIME = 0;
	unsigned long LAST_RENDERED_TIMER_TIME = 0;
	float RENDERED_AMOUNT = 0.00;
	int RENDERED_TIMER_SECONDS = 0;

	uint8_t calculateTextHeight(const uint8_t multiplier) {
		return tft.fontHeight() * multiplier;
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
		const uint8_t maxHeight = tft.height() - (calculateTextHeight(TEXT_MULTIPLIER_AMOUNT) + MARGIN_Y);
		return std::fmin(
			std::floor(maxWidth / size),
			std::floor(maxHeight / size)
		);
	}

	// http://www.barth-dev.de/about-rgb565-and-how-to-convert-into-it/
	uint16_t hexToRGB565(const std::string& hexColor) {
		uint16_t Rgb565 = 0;
		unsigned int x;
		std::stringstream ss;
		ss << std::hex << hexColor;
		ss >> x;
		uint8_t red = (x >> 16) & 255;
		uint8_t green = (x >> 8) & 255;
		uint8_t blue = x & 255;
		Rgb565 = (((red & 0xf8)<<8) + ((green & 0xfc)<<3) + (blue>>3));
		return Rgb565;
	}

	int getPrecision(const std::string &fiatCurrency) {
		if (fiatCurrency == "EUR") {
			return 2;
		}
		return 0;
	}
}

namespace display {

	void init() {
		tft.begin();
		BG_COLOR = hexToRGB565(BG_COLOR_HEX);
		TEXT_COLOR = hexToRGB565(TEXT_COLOR_HEX);
		tft.fillScreen(BG_COLOR);
		tft.setTextFont(TEXT_FONT);
	}

	void updateAmount(const float &amount, const std::string &fiatCurrency) {
		clearAmount();
		RENDERED_AMOUNT = amount;
		int precision = getPrecision(fiatCurrency);
		std::ostringstream stream;
		stream << std::fixed << std::setprecision(precision) << amount << " " << fiatCurrency;
		const std::string str = stream.str();
		logger::write("Update amount: " + str);
		const char* text = str.c_str();
		tft.setTextSize(TEXT_MULTIPLIER_AMOUNT);
		tft.setTextColor(TEXT_COLOR);
		const uint8_t textWidth = tft.textWidth(text);
		tft.setCursor((tft.width() - textWidth) / 2, MARGIN_Y);
		tft.println(text);
	}

	void clearAmount() {
		// Clear previous text by drawing a white rectangle over it.
		tft.fillRect(0, MARGIN_Y, tft.width(), calculateTextHeight(TEXT_MULTIPLIER_AMOUNT), BG_COLOR);
	}

	float getRenderedAmount() {
		return RENDERED_AMOUNT;
	}

	void renderQRCode(const std::string &dataStr) {
		clearTimer();
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
		LAST_RENDERED_QRCODE_TIME = millis();
	}

	void clearQRCode() {
		logger::write("Clear QR code");
		const uint8_t offsetY = calculateTextHeight(TEXT_MULTIPLIER_AMOUNT) + MARGIN_Y;
		tft.fillRect(0, offsetY, tft.width(), tft.height() - offsetY, BG_COLOR);
		LAST_RENDERED_QRCODE_TIME = 0;
	}

	bool hasRenderedQRCode() {
		return LAST_RENDERED_QRCODE_TIME > 0;
	}

	unsigned long getTimeSinceRenderedQRCode() {
		return LAST_RENDERED_QRCODE_TIME > 0 ? millis() - LAST_RENDERED_QRCODE_TIME : 0;
	}

	void updateTimer(const unsigned long milliseconds) {
		if (LAST_RENDERED_TIMER_TIME > 0 && millis() - LAST_RENDERED_TIMER_TIME < 500) {
			// Don't render the timer too often.
			return;
		}
		const int seconds = std::ceil(milliseconds / 1000);
		if (
			RENDERED_TIMER_SECONDS > 0 &&
			seconds == RENDERED_TIMER_SECONDS
		) {
			// Already rendered with the same number of seconds.
			// Do nothing.
			return;
		}
		clearTimer();
		std::stringstream stream;
		stream << seconds;
		const std::string str = stream.str();
		logger::write("Update timer: " + str);
		const char* text = str.c_str();
		tft.setTextSize(TEXT_MULTIPLIER_TIMER);
		tft.setTextColor(TEXT_COLOR);
		const uint8_t textWidth = tft.textWidth(text);
		const uint8_t amountTextHeight = calculateTextHeight(TEXT_MULTIPLIER_AMOUNT);
		const uint8_t offsetX = (tft.width() - textWidth) / 2;
		const uint8_t offsetY = MARGIN_Y + amountTextHeight;
		tft.setCursor(offsetX, offsetY);
		tft.println(text);
		RENDERED_TIMER_SECONDS = seconds;
	}

	void clearTimer() {
		const uint8_t amountTextHeight = calculateTextHeight(TEXT_MULTIPLIER_AMOUNT);
		const uint8_t offsetY = MARGIN_Y + amountTextHeight;
		tft.fillRect(0, offsetY, tft.width(), tft.height() - offsetY, BG_COLOR);
		RENDERED_TIMER_SECONDS = 0;
	}
}
