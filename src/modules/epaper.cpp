#include "modules/epaper.h"

// Using GxEPD2 library:
//   https://github.com/ZinggJM/GxEPD2
// Which builds on Adafruit-GFX-Library:
//   https://github.com/adafruit/Adafruit-GFX-Library

namespace {

	struct TextBoundingBox {
		int16_t x = 0;
		int16_t y = 0;
		uint16_t w = 0;
		uint16_t h = 0;
	};

	struct TextSize {
		uint16_t w = 0;
		uint16_t h = 0;
	};

	bool initialized = false;
	GxEPD2_BW<GxEPD2_420, GxEPD2_420::HEIGHT> display(GxEPD2_420(EPAPER_CS, EPAPER_DC, EPAPER_RST, EPAPER_BUSY));

	TextBoundingBox renderedAmountTextBoundingBox;

	int16_t insertFiatScreenAmountMarginTop = -32;

	const auto backgroundColor = GxEPD_WHITE;
	const auto textColor = GxEPD_BLACK;

	typedef std::vector<GFXfont> FontList;

	const FontList monospaceFonts = {
		// Ordered from largest to smallest.
		Courier_Prime_Code32pt7b,
		Courier_Prime_Code30pt7b,
		Courier_Prime_Code28pt7b,
		Courier_Prime_Code26pt7b,
		Courier_Prime_Code24pt7b,
		Courier_Prime_Code22pt7b,
		Courier_Prime_Code20pt7b,
		Courier_Prime_Code16pt7b,
		Courier_Prime_Code12pt7b
	};

	std::string currentScreen = "";

	TextSize calculateTextSize(const std::string &t_text, const GFXfont *f) {
		TextSize textSize;
		const char* text = t_text.c_str();
		display.setFont(f);
		int16_t x, y;// Not used, but needed to prevent getTextBounds() from throwing error.
		display.getTextBounds(text, 0, 0, &x, &y, &textSize.w, &textSize.h);
		return textSize;
	}

	GFXfont getBestFitFont(const std::string &text, const FontList &fonts) {
		GFXfont font;
		// We use the width of the display to calculate the best fit font.
		const uint16_t max_w = display.width() * .8;
		for (int index = 0; index < fonts.size(); index++) {
			font = fonts.at(index);
			TextSize textSize = calculateTextSize(text, &font);
			if (textSize.w <= max_w) {
				// Best fit font found.
				// Stop searching.
				break;
			}
		}
		return font;
	}

	int getBestFitQRCodeVersion(const std::string &dataStr) {
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

	std::string getAmountFiatCurrencyString(const float &amount) {
		std::ostringstream stream;
		const std::string fiatCurrency = config::get("fiatCurrency");
		const unsigned short precision = config::getFiatPrecision();
		stream << std::fixed << std::setprecision((int) precision) << amount << " " << fiatCurrency;
		return stream.str();
	}

	void clearPartialArea(const int16_t &x, const int16_t &y, const uint16_t &w, const uint16_t &h) {
		display.setPartialWindow(x, y, w, h);
		display.firstPage();
		do {
			display.fillScreen(backgroundColor);
		} while (display.nextPage());
	}

	void clearText(const TextBoundingBox &box) {
		clearPartialArea(box.x, box.y, box.w, box.h);
	}

	void renderText(const std::string &t_text, const GFXfont *f, const int16_t &x, const int16_t &y, TextBoundingBox *textBoundingBox) {
		const char* text = t_text.c_str();
		display.setFont(f);
		display.setTextColor(textColor);
		int16_t tbx, tby;
		uint16_t tbw, tbh;
		display.getTextBounds(text, 0, 0, &tbx, &tby, &tbw, &tbh);
		uint16_t w_adjust = tbw * .15;
		uint16_t h_adjust = tbh * .5;
		tbw += w_adjust;
		tbh += h_adjust;
		int16_t box_x = x - (tbw / 2);
		int16_t box_y = y - (tbh / 2);
		int16_t cursor_x = box_x + (w_adjust / 2);
		int16_t cursor_y = (box_y + tbh) - (h_adjust * .8);// Cursor y-coordinate is the text baseline.
		display.setPartialWindow(box_x, box_y, tbw, tbh);
		// Uncomment the following line to print debug info to serial monitor:
		// std::cout << "renderText \"" << t_text << "\" / x, y, w, h: " << +box_x << ", " << +box_y << ", " << +tbw << ", " << +tbh << " " << std::endl;
		display.firstPage();
		do {
			display.fillScreen(backgroundColor);
			// Uncomment the following line to draw the outer bounding box.
			// display.drawRect(box_x, box_y, tbw, tbh, textColor);
			display.setCursor(cursor_x, cursor_y);
			display.print(text);
		} while (display.nextPage());
		if (textBoundingBox != NULL) {
			textBoundingBox->x = box_x;
			textBoundingBox->y = box_y;
			textBoundingBox->w = tbw;
			textBoundingBox->h = tbh;
		}
	}

	void renderQRCode(const std::string &t_data, const int16_t &x, const int16_t &y, const uint16_t &max_w, const uint16_t &max_h) {
		const char* data = t_data.c_str();
		const int version = getBestFitQRCodeVersion(t_data);
		QRCode qrcode;
		uint8_t qrcodeData[qrcode_getBufferSize(version)];
		qrcode_initText(&qrcode, qrcodeData, version, ECC_LOW, data);
		int16_t w = 0;
		int16_t h = 0;
		int scale = std::min(std::floor(max_w / qrcode.size), std::floor(max_h / qrcode.size));
		w = qrcode.size * scale;
		h = qrcode.size * scale;
		int16_t box_x = x - (w / 2);
		int16_t box_y = y - (h / 2);
		display.setPartialWindow(box_x, box_y, w, h);
		display.firstPage();
		do {
			display.fillScreen(backgroundColor);
			// Uncomment the following line to draw the outer bounding box.
			display.drawRect(box_x, box_y, w, h, textColor);
			for (uint8_t y = 0; y < qrcode.size; y++) {
				for (uint8_t x = 0; x < qrcode.size; x++) {
					int color = qrcode_getModule(&qrcode, x, y) ? textColor: backgroundColor;
					display.fillRect(box_x + scale*x, box_y + scale*y, scale, scale, color);
				}
			}
		} while (display.nextPage());
	}

	void scrub() {
		// Repeatedly clear the screen w/ alternating colors.
		// This ensures that no pixels are left over from a previous state.
		display.clearScreen((uint8_t) textColor);
		display.clearScreen((uint8_t) backgroundColor);
		display.clearScreen((uint8_t) textColor);
	}

	std::string getInstructionsUrl() {
		const std::string apiKeyId = config::get("apiKey.id");
		std::string instructionsUrl = config::get("instructionsUrl");
		return util::replaceFirstOccurrence(
			instructionsUrl,
			"{{API_KEY_ID}}",
			util::urlEncode(apiKeyId)
		);
	}
}

namespace epaper {

	void init() {
		display.init(0);
		SPI.end();// Release standard SPI pins.
		SPI.begin(EPAPER_CLK, EPAPER_MISO, EPAPER_DIN, EPAPER_CS);
		if (display.epd2.panel == GxEPD2::GDEW042T2) {
			logger::write("E-Paper display initialized and ready for use");
			initialized = true;
			display.setRotation(0);
			epaper::showSplashScreen();
			// Uncomment the following lines to render each screen after a short delay between each.
			// delay(2000);
			// epaper::showInstructionsScreen();
			// delay(2000);
			// epaper::showInsertFiatScreen(0);
			// delay(2000);
			// const std::string referenceCode = util::generateRandomWords(5);
			// epaper::showTransactionCompleteScreen(
			// 	2,
			// 	util::toUpperCase(util::lnurlEncode(util::createSignedWithdrawUrl(2, referenceCode))),
			// 	referenceCode
			// );
		} else {
			logger::write("Unknown display connected. This device supports WaveShare 4.2 inch e-paper b/w");
		}
	}

	bool isInitialized() {
		return initialized;
	}

	std::string getCurrentScreen() {
		return currentScreen;
	}

	void showSplashScreen() {
		if (!isInitialized()) return;
		scrub();
		display.drawImage(BLESKOMAT_SPLASH_SCREEN_400x300, 0, 0, display.epd2.WIDTH, display.epd2.HEIGHT, false, false, true);
		const std::string text = "(press button to begin)";
		uint8_t margin = 40;
		int16_t text_x = display.width() / 2;// center
		int16_t text_y = display.height() - margin;// bottom
		renderText(text, &OpenSans_Light9pt7b, text_x, text_y, NULL);
		currentScreen = "splash";
	}

	void showInstructionsScreen() {
		if (!isInitialized()) return;
		display.clearScreen();
		display.drawImage(BLESKOMAT_INSTRUCTIONS_SCREEN_400x300, 0, 0, display.epd2.WIDTH, display.epd2.HEIGHT, false, false, true);
		const std::string instructionsUrl = getInstructionsUrl();
		int16_t margin = 15;
		uint16_t qrcode_w = 100;
		uint16_t qrcode_h = 100;
		int16_t qrcode_x = 280 + (qrcode_w / 2);
		int16_t qrcode_y = margin + (qrcode_h / 2);
		renderQRCode(instructionsUrl, qrcode_x, qrcode_y, qrcode_w, qrcode_h);
		currentScreen = "instructions";
	}

	void showInsertFiatScreen(const float &amount) {
		if (!isInitialized()) return;
		display.clearScreen();
		updateInsertFiatScreenAmount(amount);
		int16_t center_x = display.width() / 2;// center
		// Keep track of the bounding box of the previously rendered text - start with amount text.
		TextBoundingBox prevText_box = renderedAmountTextBoundingBox;

		const double buyLimit = config::getBuyLimit();
		if (buyLimit > 0) {
			const std::string limitText = "Limit = " + config::get("buyLimit") + " " + config::get("fiatCurrency");
			int16_t limitText_y = prevText_box.y + prevText_box.h + 15;
			renderText(limitText, &OpenSans_Light9pt7b, center_x, limitText_y, &prevText_box);
		}

		// Instructional text #1:
		const std::string text1 = "insert bills and/or coins";
		int16_t text1_y = prevText_box.y + prevText_box.h + 45;
		renderText(text1, &OpenSans_Light12pt7b, center_x, text1_y, &prevText_box);

		// Instructional text #2:
		const std::string text2 = "(press button when done)";
		int16_t text2_y = prevText_box.y + prevText_box.h + 15;
		renderText(text2, &OpenSans_Light9pt7b, center_x, text2_y, &prevText_box);

		currentScreen = "insertFiat";
	}

	void updateInsertFiatScreenAmount(const float &amount) {
		if (!isInitialized()) return;
		if (renderedAmountTextBoundingBox.w > 0) {
			// Clear previously rendered amount.
			clearText(renderedAmountTextBoundingBox);
		}
		// Render amount + fiat currency symbol (top-center).
		const std::string text = getAmountFiatCurrencyString(amount);
		int16_t x = (display.width() / 2);
		int16_t y = (display.height() / 2) + insertFiatScreenAmountMarginTop;
		GFXfont font = getBestFitFont(text, monospaceFonts);
		renderText(text, &font, x, y, &renderedAmountTextBoundingBox);
	}

	void showTransactionCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &referenceCode
	) {
		if (!isInitialized()) return;
		display.clearScreen();

		// Render QR code.
		// Use the left 2/3rds of the screen.
		uint16_t qr_max_w = (display.width() * 2) / 3;
		uint16_t qr_max_h = 216;
		int16_t qr_x = qr_max_w / 2;
		int16_t qr_y = display.height() / 2;
		renderQRCode(qrcodeData, qr_x, qr_y, qr_max_w, qr_max_h);

		std::cout << "QR Code: " << qrcodeData << std::endl;

		// Render amount + fiat currency symbol (top-center).
		const std::string text = getAmountFiatCurrencyString(amount);
		int16_t margin = 24;
		int16_t text_x = (display.width() / 2);// center
		int16_t text_y = margin;
		TextBoundingBox text_bbox;
		renderText(text, &Courier_Prime_Code12pt7b, text_x, text_y, &text_bbox);

		// Render instructional text (bottom-center).
		const std::string text2 = "scan with your mobile wallet app";
		int16_t text2_x = (display.width() / 2);// center
		int16_t text2_y = display.height() - margin;// bottom + margin
		renderText(text2, &OpenSans_Light9pt7b, text2_x, text2_y, NULL);

		if (referenceCode != "") {
			// Render reference code.
			// Use the right 1/3rd of the screen.
			const std::string text3 = "ref. code:";
			int16_t text3_x = (((display.width() * 2) / 3) + (display.width() / 6)) - 18;
			int16_t text3_y = text_bbox.h + 56;
			TextBoundingBox text3_bbox;
			renderText(text3, &OpenSans_Light9pt7b, text3_x, text3_y, &text3_bbox);
			TextSize word_textsize = calculateTextSize("check", &Courier_Prime_Code12pt7b);
			std::vector<std::string> referenceCodeWords = util::stringListToStringVector(referenceCode, ' ');
			for (int index = 0; index < referenceCodeWords.size(); index++) {
				std::string word = referenceCodeWords.at(index);
				int16_t word_x = text3_x;
				int16_t word_y = text3_bbox.y + text3_bbox.h + 24 + (index * (word_textsize.h + 14));
				renderText(word, &Courier_Prime_Code12pt7b, word_x, word_y, NULL);
			}
		}

		currentScreen = "transactionComplete";
	}

	void showWifiAccessPointConnectionDetailsScreen(
		const std::string &ssid,
		const std::string &password,
		const std::string &configurationString
	) {
		if (!isInitialized()) return;
		display.clearScreen();

		int16_t margin = 24;

		// Render SSID as text (top-center).
		const std::string ssid_text = "SSID: " + ssid;
		GFXfont ssid_font = getBestFitFont(ssid_text, monospaceFonts);
		int16_t ssid_text_x = (display.width() / 2);// center
		int16_t ssid_text_y = margin;// top + margin
		TextBoundingBox ssid_text_bbox;
		renderText(ssid_text, &ssid_font, ssid_text_x, ssid_text_y, &ssid_text_bbox);

		// Render password as text (bottom-center).
		const std::string password_text = "PW: " + password;
		GFXfont password_font = getBestFitFont(password_text, monospaceFonts);
		int16_t password_text_x = (display.width() / 2);// center
		int16_t password_text_y = display.height() - margin;// bottom + margin
		TextBoundingBox password_text_bbox;
		renderText(password_text, &password_font, password_text_x, password_text_y, &password_text_bbox);

		// Render WiFi connection details as QR code (center).
		uint16_t qr_max_w = display.width();
		uint16_t qr_max_h = display.height() - (ssid_text_bbox.h + password_text_bbox.h + (margin * 2));
		int16_t qr_x = display.width() / 2;// center
		int16_t qr_y = display.height() / 2;// center
		renderQRCode(configurationString, qr_x, qr_y, qr_max_w, qr_max_h);

		currentScreen = "wifiAccessPointConnectionDetails";
	}

	void showWifiAccessPointOpenWebInterfaceScreen(const std::string &url) {
		if (!isInitialized()) return;
		display.clearScreen();

		int16_t margin = 24;

		// Render instructions (top-center).
		const std::string instructions = "Open web page in your browser";
		GFXfont instructions_font = getBestFitFont(instructions, monospaceFonts);
		int16_t instructions_x = (display.width() / 2);// center
		int16_t instructions_y = margin;// top + margin
		TextBoundingBox instructions_bbox;
		renderText(instructions, &instructions_font, instructions_x, instructions_y, &instructions_bbox);

		// Render URL as text (bottom-center).
		GFXfont url_font = getBestFitFont(url, monospaceFonts);
		int16_t url_x = (display.width() / 2);// center
		int16_t url_y = display.height() - margin;// bottom + margin
		TextBoundingBox url_bbox;
		renderText(url, &url_font, url_x, url_y, &url_bbox);

		// Render URL as QR code (center).
		uint16_t qr_max_w = display.width();
		uint16_t qr_max_h = display.height() - (instructions_bbox.h + url_bbox.h + (margin * 2));
		int16_t qr_x = display.width() / 2;// center
		int16_t qr_y = display.height() / 2;// center
		renderQRCode(url, qr_x, qr_y, qr_max_w, qr_max_h);

		currentScreen = "wifiAccessPointOpenWebInterface";
	}
}
