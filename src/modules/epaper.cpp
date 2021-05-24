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

	int16_t insertFiatScreenAmountMarginTop = -64;

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
		Courier_Prime_Code12pt7b,
		Courier_Prime_Code10pt7b,
		Courier_Prime_Code8pt7b
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

	void renderText(
		const std::string &t_text,
		const GFXfont *f,
		const int16_t &x,
		const int16_t &y,
		TextBoundingBox *textBoundingBox,
		const bool &centerJustify = true
	) {
		const char* text = t_text.c_str();
		display.setFont(f);
		display.setTextColor(textColor);
		int16_t tbx, tby;
		uint16_t tbw, tbh;
		display.getTextBounds(text, 0, 0, &tbx, &tby, &tbw, &tbh);
		int16_t box_x = x;
		int16_t box_y = y;
		int16_t w_adjust = 4;
		int16_t h_adjust = 8;
		tbw += w_adjust;
		tbh += h_adjust;
		if (centerJustify) {
			box_x -= (tbw / 2);
			box_y -= (tbh / 2);
		}
		int16_t cursor_x = box_x;
		int16_t cursor_y = box_y + tbh;
		cursor_y -= (h_adjust - 2);
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

	void renderQRCode(
		const std::string &t_data,
		const int16_t &x,
		const int16_t &y,
		const uint16_t &max_w,
		const uint16_t &max_h,
		const bool &centerJustify = true
	) {
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
		int16_t box_x = x;
		int16_t box_y = y;
		if (centerJustify) {
			box_x -= (w / 2);
			box_y -= (h / 2);
		}
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
		std::string instructionsUrl = config::get("webUrl");
		instructionsUrl += "/intro?id=" + util::urlEncode(apiKeyId);
		return instructionsUrl;
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
			// Uncomment the following lines to render each screen after a short delay between each.
			// epaper::showSplashScreen();
			// delay(2000);
			// epaper::showDisabledScreen();
			// delay(2000);
			// epaper::showInstructionsScreen();
			// delay(2000);
			// epaper::showInsertFiatScreen(0);
			// delay(2000);
			// const double amount = 1.00;
			// const std::string referencePhrase = util::generateRandomPhrase(5);
			// Lnurl::Query customParams;
			// customParams["r"] = referencePhrase;
			// const double exchangeRate = network::getExchangeRate();
			// if (exchangeRate > 0) {
			// 	customParams["er"] = std::to_string(exchangeRate);
			// }
			// const std::string qrcodeData = util::toUpperCase(util::lnurlEncode(util::createSignedLnurlWithdraw(amount, customParams)));
			// epaper::showTransactionCompleteScreen(amount, qrcodeData, referencePhrase);
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

	void showDisabledScreen() {
		if (!isInitialized()) return;
		display.clearScreen();
		int16_t margin = 24;
		const std::string text = "Temporarily disabled";
		int16_t text_x = (display.width() / 2);// center
		int16_t text_y = (display.height() / 2) - margin;
		GFXfont font = getBestFitFont(text, monospaceFonts);
		TextBoundingBox text_bbox;
		renderText(text, &font, text_x, text_y, &text_bbox);
		const std::string text2 = "Please check again later";
		int16_t text2_x = display.width() / 2;// center
		int16_t text2_y = text_bbox.h + text_bbox.y + margin;// bottom
		renderText(text2, &OpenSans_Light9pt7b, text2_x, text2_y, NULL);
		currentScreen = "disabled";
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
			std::string limitText = "Limit = ";
			limitText += util::doubleToStringWithPrecision(buyLimit, config::getFiatPrecision());
			limitText += " " + config::get("fiatCurrency");
			int16_t limitText_y = prevText_box.y + prevText_box.h + 24;
			renderText(limitText, &OpenSans_Light9pt7b, center_x, limitText_y, &prevText_box);
		}

		const double exchangeRate = network::getExchangeRate();
		if (buyLimit > 0) {
			std::string exchangeRateText = "1 BTC = ";
			exchangeRateText += util::doubleToStringWithPrecision(exchangeRate, config::getFiatPrecision());
			exchangeRateText += " " + config::get("fiatCurrency");
			int16_t exchangeRateText_y = prevText_box.y + prevText_box.h + 24;
			renderText(exchangeRateText, &OpenSans_Light9pt7b, center_x, exchangeRateText_y, &prevText_box);
		}

		// Instructional text #1:
		const std::string text1 = "insert bills and/or coins";
		int16_t text1_y = prevText_box.y + prevText_box.h + 48;
		renderText(text1, &OpenSans_Light12pt7b, center_x, text1_y, &prevText_box);

		// Instructional text #2:
		const std::string text2 = "(press button when done)";
		int16_t text2_y = prevText_box.y + prevText_box.h + 16;
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
		const std::string &referencePhrase
	) {
		if (!isInitialized()) return;
		display.clearScreen();

		// Margin between rendered elements.
		int16_t margin = 16;

		// Render amount + fiat currency symbol (top-left).
		const std::string text = getAmountFiatCurrencyString(amount);
		int16_t text_x = margin;// left
		int16_t text_y = margin;
		TextBoundingBox text_bbox;
		renderText(text, &Courier_Prime_Code12pt7b, text_x, text_y, &text_bbox, false);

		const std::string instr_text1 = "scan with mobile app to redeem";
		const std::string instr_text2 = "and take a picture for your records";
		TextSize instr_text1_size = calculateTextSize(instr_text1, &OpenSans_Light9pt7b);
		TextSize instr_text2_size = calculateTextSize(instr_text2, &OpenSans_Light9pt7b);

		// Render QR code.
		// Use the left 2/3rds of the screen.
		uint16_t qr_max_w = (display.width() * 2) / 3;
		uint16_t qr_max_h = display.height() - (margin + text_bbox.h + margin + margin + instr_text2_size.h + (margin / 2) + instr_text1_size.h + margin);
		int16_t qr_x = margin;
		int16_t qr_y = (margin + text_bbox.h + margin);
		renderQRCode(qrcodeData, qr_x, qr_y, qr_max_w, qr_max_h, false);

		// Render instructional text (bottom-left).
		int16_t instr_text2_x = margin;// left
		int16_t instr_text2_y = display.height() - (instr_text2_size.h + (margin * 1.5));// bottom
		TextBoundingBox instr_text2_bbox;
		renderText(instr_text2, &OpenSans_Light9pt7b, instr_text2_x, instr_text2_y, &instr_text2_bbox, false);

		int16_t instr_text1_x = margin;// left
		int16_t instr_text1_y = instr_text2_bbox.y - (instr_text1_size.h + (margin / 2));// bottom
		renderText(instr_text1, &OpenSans_Light9pt7b, instr_text1_x, instr_text1_y, NULL, false);

		// Render reference code.
		// Use the right 1/3rd of the screen.
		std::vector<std::string> words = util::stringListToStringVector(referencePhrase, ' ');
		const std::string deviceReferencePhrase = config::get("referencePhrase");
		if (deviceReferencePhrase != "") {
			const std::vector<std::string> deviceWords = util::stringListToStringVector(deviceReferencePhrase, ' ');
			words.insert(words.end(), deviceWords.begin(), deviceWords.end());
		}
		TextBoundingBox last_word_bbox;
		for (int index = 0; index < words.size(); index++) {
			std::string word = util::toUpperCase(words.at(index));
			TextSize word_textsize = calculateTextSize(word, &Courier_Prime_Code10pt7b);
			int16_t word_x = display.width() - (word_textsize.w + margin);// right
			int16_t word_y = last_word_bbox.y + last_word_bbox.h + (margin * .65);
			renderText(word, &Courier_Prime_Code10pt7b, word_x, word_y, &last_word_bbox, false);
		}

		currentScreen = "transactionComplete";
	}
}
