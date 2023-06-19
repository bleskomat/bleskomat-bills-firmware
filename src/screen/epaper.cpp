#include "screen/epaper.h"

//
//  Using GxEPD2 library:
//  	https://github.com/ZinggJM/GxEPD2
//  Which builds on Adafruit-GFX-Library:
//  	https://github.com/adafruit/Adafruit-GFX-Library
//
//  For utf-8 support, the following additional library is used:
//  https://github.com/olikraus/U8g2_for_Adafruit_GFX
//
//  Example usage:
//  https://github.com/ZinggJM/GxEPD2/blob/master/examples/GxEPD2_U8G2_Fonts_Example/GxEPD2_U8G2_Fonts_Example.ino
//

namespace {

	enum class State {
		uninitialized,
		initialized,
		failed
	};
	State state = State::uninitialized;

	GxEPD2_BW<GxEPD2_420, GxEPD2_420::HEIGHT> display(GxEPD2_420(EPAPER_CS, EPAPER_DC, EPAPER_RST, EPAPER_BUSY));
	U8G2_FOR_ADAFRUIT_GFX u8g2Fonts;

	struct BoundingBox {
		int16_t x = 0;
		int16_t y = 0;
		uint16_t w = 0;
		uint16_t h = 0;
	};

	BoundingBox renderedAmountTextBoundingBox;

	const auto backgroundColor = GxEPD_WHITE;
	const auto textColor = GxEPD_BLACK;

	typedef const uint8_t* Font;
	typedef std::vector<Font> FontList;

	FontList monospaceFonts = {
		// Ordered from largest (top) to smallest (bottom).
		u8g2_courier_prime_code_48pt,
		u8g2_courier_prime_code_44pt,
		u8g2_courier_prime_code_40pt,
		u8g2_courier_prime_code_36pt,
		u8g2_courier_prime_code_32pt,
		u8g2_courier_prime_code_28pt,
		u8g2_courier_prime_code_24pt,
		u8g2_courier_prime_code_20pt,
		u8g2_courier_prime_code_16pt,
		u8g2_courier_prime_code_14pt,
		u8g2_courier_prime_code_12pt,
		u8g2_courier_prime_code_11pt,
		u8g2_courier_prime_code_9pt,
		u8g2_courier_prime_code_8pt
	};

	FontList brandFonts = {
		// Ordered from largest (top) to smallest (bottom).
		u8g2_checkbooklightning_48pt,
		u8g2_checkbooklightning_44pt,
		u8g2_checkbooklightning_40pt,
		u8g2_checkbooklightning_36pt
	};

	Font monospaceFontSmall = u8g2_courier_prime_code_12pt;
	Font monospaceFontNormal = u8g2_courier_prime_code_16pt;

	std::string currentScreen = "";

	BoundingBox calculateTextSize(const std::string &t_text, const Font font) {
		BoundingBox bbox;
		const char* text = t_text.c_str();
		u8g2Fonts.setFontMode(1);// use u8g2 transparent mode (this is default)
		u8g2Fonts.setFontDirection(0);// left to right (this is default)
		u8g2Fonts.setForegroundColor(textColor);// apply Adafruit GFX color
		u8g2Fonts.setBackgroundColor(backgroundColor);// apply Adafruit GFX color
		u8g2Fonts.setFont(font);
		int16_t tbw = u8g2Fonts.getUTF8Width(text);// text box width
		int16_t ta = u8g2Fonts.getFontAscent();// positive
		int16_t td = u8g2Fonts.getFontDescent();// negative; in mathematicians view
		int16_t tbh = ta - td;// text box height
		bbox.w = tbw;
		bbox.h = tbh;
		return bbox;
	}

	Font getBestFitFont(const std::string &text, const FontList fonts, uint16_t max_w = 0, uint16_t max_h = 0) {
		if (max_w == 0) {
			max_w = display.epd2.WIDTH;
		}
		if (max_h == 0) {
			max_h = display.epd2.HEIGHT;
		}
		for (uint8_t index = 0; index < fonts.size(); index++) {
			const Font font = fonts.at(index);
			const BoundingBox bbox = calculateTextSize(text, font);
			if (bbox.w <= max_w && bbox.h <= max_h) {
				// Best fit font found.
				return font;
			}
		}
		// Default to last font in list - should be smallest.
		return fonts.back();
	}

	std::string getAmountFiatCurrencyString(const float &amount) {
		return util::floatToStringWithPrecision(amount, config::getUnsignedInt("fiatPrecision")) + " " + config::getString("fiatCurrency");
	}

	BoundingBox renderText(
		const std::string &t_text,
		const Font font,
		const int16_t &x,
		const int16_t &y,
		const bool &center = true
	) {
		BoundingBox bbox;
		const char* text = t_text.c_str();
		u8g2Fonts.setFontMode(0);// use u8g2 non-transparent mode
		u8g2Fonts.setFontDirection(0);// left to right (this is default)
		u8g2Fonts.setForegroundColor(textColor);// apply Adafruit GFX color
		u8g2Fonts.setBackgroundColor(backgroundColor);// apply Adafruit GFX color
		u8g2Fonts.setFont(font);
		int16_t tbw = u8g2Fonts.getUTF8Width(text);// text box width
		int16_t ta = u8g2Fonts.getFontAscent();// positive
		int16_t td = u8g2Fonts.getFontDescent();// negative; in mathematicians view
		int16_t tbh = ta - td;// text box height
		int16_t box_x = x;
		int16_t box_y = y;
		int16_t w_adjust = 4;
		int16_t h_adjust = 8;
		tbw += w_adjust;
		tbh += h_adjust;
		if (center) {
			box_x -= (tbw / 2);
			box_y -= (tbh / 2);
		}
		int16_t cursor_x = box_x;
		int16_t cursor_y = box_y + tbh;
		cursor_y -= (h_adjust - 2);
		display.fillRect(box_x, box_y, tbw, tbh, backgroundColor);
		u8g2Fonts.setCursor(cursor_x, cursor_y);
		u8g2Fonts.print(text);
		bbox.x = box_x;
		bbox.y = box_y;
		bbox.w = tbw;
		bbox.h = tbh;
		// Uncomment the following line to print debug info to serial monitor:
		// std::cout << "renderText \"" << t_text << "\" / x, y, w, h: " << +box_x << ", " << +box_y << ", " << +tbw << ", " << +tbh << " " << std::endl;
		// Uncomment the following line to draw the outer bounding box.
		// display.drawRect(box_x, box_y, tbw, tbh, textColor);
		return bbox;
	}

	BoundingBox renderQRCode(
		const std::string &t_data,
		const int16_t &x,
		const int16_t &y,
		const uint16_t &max_w,
		const uint16_t &max_h,
		const bool &center = true
	) {
		BoundingBox bbox;
		try {
			const char* data = t_data.c_str();
			uint8_t version = 1;
			while (version <= 40) {
				const uint16_t bufferSize = qrcode_getBufferSize(version);
				QRCode qrcode;
				uint8_t qrcodeData[bufferSize];
				const int8_t result = qrcode_initText(&qrcode, qrcodeData, version, ECC_LOW, data);
				if (result == 0) {
					// QR encoding successful.
					uint8_t scale = std::min(std::floor(max_w / qrcode.size), std::floor(max_h / qrcode.size));
					uint16_t w = qrcode.size * scale;
					uint16_t h = w;
					int16_t box_x = x;
					int16_t box_y = y;
					if (center) {
						box_x -= (w / 2);
						box_y -= (h / 2);
					}
					display.fillRect(box_x, box_y, w, h, backgroundColor);
					for (uint8_t y = 0; y < qrcode.size; y++) {
						for (uint8_t x = 0; x < qrcode.size; x++) {
							auto color = qrcode_getModule(&qrcode, x, y) ? textColor: backgroundColor;
							display.fillRect(box_x + scale*x, box_y + scale*y, scale, scale, color);
						}
					}
					bbox.x = box_x;
					bbox.y = box_y;
					bbox.w = w;
					bbox.h = h;
					break;
				} else if (result == -2) {
					// Data was too long for the QR code version.
					version++;
				} else if (result == -1) {
					throw std::runtime_error("Render QR code failure: Unable to detect mode");
				} else {
					throw std::runtime_error("Render QR code failure: Unknown failure case");
				}
			}
		} catch (const std::exception &e) {
			std::cerr << e.what() << std::endl;
		}
		return bbox;
	}

	void scrub() {
		// Repeatedly clear the screen w/ alternating colors.
		// This ensures that no pixels are left over from a previous state.
		display.clearScreen((uint8_t) textColor);
		display.clearScreen((uint8_t) backgroundColor);
	}

	uint16_t numWrites = 0;
	bool isDirty(const uint16_t maxWrites = 5) {
		return ++numWrites > maxWrites;
	}

	bool startNewScreen(const uint16_t maxWrites = 5) {
		bool scrubbed = false;
		if (currentScreen == "tradeComplete" || isDirty(maxWrites)) {
			scrub();
			scrubbed = true;
			numWrites = 1;
		}
		display.setFullWindow();
		display.fillScreen(backgroundColor);
		return scrubbed;
	}

	void finishNewScreen(const std::string &name) {
		currentScreen = name;
		display.displayWindow(0, 0, display.epd2.WIDTH, display.epd2.HEIGHT);
	}

	std::string getInstructionsUrl() {
		const std::string apiKeyId = config::getString("apiKey.id");
		std::string instructionsUrl = config::getString("webUrl");
		instructionsUrl += "/intro?id=" + util::urlEncode(apiKeyId);
		return instructionsUrl;
	}

	std::vector<std::string> splitTextIntoWords(const std::string &text) {
		std::vector<std::string> words;
		std::stringstream ss(text);
		std::string word;
		while (std::getline(ss, word, ' ')) {
			words.push_back(word);
		}
		return words;
	}

	std::vector<std::string> splitTextIntoLines(const std::string &text, const uint8_t numLines = 2) {
		std::vector<std::string> lines;
		std::vector<std::string> words = splitTextIntoWords(text);
		const uint16_t maxCharWidth = std::ceil(text.size() / numLines) + 4;
		std::string line;
		for (uint8_t index = 0; index < words.size(); index++) {
			if (line != "") {
				line += " ";
			}
			line += words[index];
			if (lines.size() + 1 < numLines && line.size() + 1 + words[index + 1].size() > maxCharWidth) {
				lines.push_back(line);
				line = "";
			}
		}
		lines.push_back(line);
		return lines;
	}
}

namespace screen_epaper {

	void init() {}

	void loop() {
		if (state == State::uninitialized && !jsonRpc::inUse()) {
			logger::write("Initializing e-paper display...");
			if (display.epd2.panel == GxEPD2::GDEW042T2) {
				try {
					display.init(0);
					u8g2Fonts.begin(display);// connect u8g2 procedures to Adafruit GFX
					// It is necessary to stop other SPI device(s) before initializing SPI for the epaper display.
					SPI.end();
					SPI.begin(EPAPER_CLK, EPAPER_MISO, EPAPER_DIN, EPAPER_CS);
					display.setRotation(0);
					state = State::initialized;
				} catch (const std::exception &e) {
					logger::write("Failed to initialize e-paper display: " + std::string(e.what()), "error");
					state = State::failed;
				}
			} else {
				logger::write("Unknown display connected. This firmware supports WaveShare 4.2 inch e-paper b/w", "warn");
				state = State::failed;
			}
		}
	}

	bool isReady() {
		return state == State::initialized;
	}

	void showSplashScreen() {
		if (!screen_epaper::isReady()) return;
		logger::write("Show screen: Splash");
		startNewScreen();
		const int16_t margin = 20;
		const int16_t center_x = (display.epd2.WIDTH / 2);
		BoundingBox prevText_bbox;
		{
			const std::string text = "BLESKOMAT";
			const Font font = getBestFitFont(text, brandFonts);
			const BoundingBox bbox = calculateTextSize(text, font);
			const int16_t pos_x = center_x;
			const int16_t pos_y = (display.epd2.HEIGHT / 2) - margin;// center
			prevText_bbox = renderText(text, font, pos_x, pos_y);
		}
		{
			const std::string text = i18n::t("Bitcoin Lightning devices made easy.");
			const uint16_t max_w = std::ceil((display.epd2.WIDTH * 4) / 5);
			const Font font = getBestFitFont(text, monospaceFonts, max_w);
			const BoundingBox bbox = calculateTextSize(text, font);
			const int16_t pos_x = center_x;
			const int16_t pos_y = prevText_bbox.y - (bbox.h + (margin / 2));
			renderText(text, font, pos_x, pos_y);
		}
		{
			const std::string text = "(" + i18n::t("press button to begin") + ")";
			const uint16_t max_w = std::ceil((display.epd2.WIDTH * 4) / 5);
			const Font font = getBestFitFont(text, monospaceFonts, max_w);
			const BoundingBox bbox = calculateTextSize(text, font);
			const int16_t pos_x = center_x;
			const int16_t pos_y = display.epd2.HEIGHT - (bbox.h + margin);
			renderText(text, font, pos_x, pos_y);
		}
		finishNewScreen("splash");
	}

	void showDisabledScreen() {
		if (!screen_epaper::isReady()) return;
		logger::write("Show screen: Disabled");
		startNewScreen();
		const int16_t margin = 20;
		const std::string text = i18n::t("Temporarily disabled");
		const int16_t text_x = (display.epd2.WIDTH / 2);// center
		const int16_t text_y = (display.epd2.HEIGHT / 2) - margin;
		const Font font = getBestFitFont(text, monospaceFonts);
		const BoundingBox text_bbox = renderText(text, font, text_x, text_y);
		const std::string text2 = i18n::t("Please check again later");
		const int16_t text2_x = display.epd2.WIDTH / 2;// center
		const int16_t text2_y = text_bbox.h + text_bbox.y + margin;// bottom
		renderText(text2, monospaceFontSmall, text2_x, text2_y);
		finishNewScreen("disabled");
	}

	void showInstructionsScreen() {
		if (!screen_epaper::isReady()) return;
		logger::write("Show screen: Instructions");
		startNewScreen();
		const std::string instructionsUrl = getInstructionsUrl();
		const int16_t margin = 20;
		const int16_t line_spacing = 8;
		BoundingBox qrcode_bbox;
		{
			const uint16_t qrcode_w = 100;
			const uint16_t qrcode_h = 100;
			const int16_t qrcode_x = margin;
			const int16_t qrcode_y = margin;
			qrcode_bbox = renderQRCode(instructionsUrl, qrcode_x, qrcode_y, qrcode_w, qrcode_h, false);
		}
		{
			std::vector<std::string> lines = splitTextIntoLines(i18n::t("Scan this QR code to see a list of supported mobile wallet apps"), 3);
			int16_t line1_x = qrcode_bbox.x + qrcode_bbox.w + margin;// right of the QR code
			int16_t line1_y = qrcode_bbox.y;// align w/ QR code
			const int16_t max_w = display.epd2.WIDTH - (line1_x + margin);
			const Font font = u8g2_courier_prime_code_11pt;
			BoundingBox prevText_bbox;
			prevText_bbox = renderText(lines[0], font, line1_x, line1_y, false);
			int16_t line2_y = prevText_bbox.y + prevText_bbox.h + line_spacing;
			prevText_bbox = renderText(lines[1], font, line1_x, line2_y, false);
			int16_t line3_y = prevText_bbox.y + prevText_bbox.h + line_spacing;
			prevText_bbox = renderText(lines[2], font, line1_x, line3_y, false);
		}
		{
			const int16_t box_margin = line_spacing / 2;
			const int16_t box_x = margin;
			const int16_t box_y = qrcode_bbox.y + qrcode_bbox.h + margin;
			const uint16_t box_w = display.epd2.WIDTH - (margin * 2);
			const uint16_t box_h = display.epd2.HEIGHT - (box_y + margin);
			display.drawRect(box_x, box_y, box_w, box_h, textColor);
			const std::string numbering1 = "0";
			const std::string numbering2 = "1";
			const std::string numbering3 = "2";
			const std::string numbering4 = "3";
			const Font numbering_font = u8g2_courier_prime_code_16pt;
			BoundingBox numbering1_bbox = calculateTextSize(numbering1, numbering_font);
			int16_t numbering1_x = box_x + box_margin + (numbering1_bbox.w / 2);// left, inside box
			int16_t numbering1_y = box_y + box_margin;// top, inside box
			numbering1_bbox = renderText(numbering1, numbering_font, numbering1_x, numbering1_y, false);
			int16_t numbering2_y = numbering1_bbox.y + numbering1_bbox.h + line_spacing;
			BoundingBox numbering2_bbox = renderText(numbering2, numbering_font, numbering1_x, numbering2_y, false);
			int16_t numbering3_y = numbering2_bbox.y + numbering2_bbox.h + line_spacing;
			BoundingBox numbering3_bbox = renderText(numbering3, numbering_font, numbering1_x, numbering3_y, false);
			int16_t numbering4_y = numbering3_bbox.y + numbering3_bbox.h + line_spacing;
			BoundingBox numbering4_bbox = renderText(numbering4, numbering_font, numbering1_x, numbering4_y, false);
			const std::string text4 = i18n::t("Install supported mobile wallet app");
			const std::string text5 = i18n::t("Insert bills");
			const std::string text6 = i18n::t("Press the button when done");
			const std::string text7 = i18n::t("Scan QR code with mobile wallet app");
			const Font text4_font = u8g2_courier_prime_code_9pt;
			int16_t text4_x = numbering1_bbox.x + numbering1_bbox.w + (line_spacing / 2);// left, next to the numbering
			int16_t text4_y = numbering1_bbox.y + (line_spacing / 2);// align w/ first number
			renderText(text4, text4_font, text4_x, text4_y, false);
			int16_t text5_y = numbering2_bbox.y + (line_spacing / 2);// align w/ second number
			renderText(text5, text4_font, text4_x, text5_y, false);
			int16_t text6_y = numbering3_bbox.y + (line_spacing / 2);// align w/ third number
			renderText(text6, text4_font, text4_x, text6_y, false);
			int16_t text7_y = numbering4_bbox.y + (line_spacing / 2);// align w/ fourth number
			renderText(text7, text4_font, text4_x, text7_y, false);
		}
		finishNewScreen("instructions");
	}

	void showInsertFiatScreen(const float &amount) {
		if (!screen_epaper::isReady()) return;
		logger::write("Show screen: Insert Fiat");
		startNewScreen();
		const int16_t margin = 20;
		const int16_t center_x = display.epd2.WIDTH / 2;// center
		BoundingBox prevText_bbox;
		{
			// Render amount + fiat currency symbol (top-center).
			const std::string text = getAmountFiatCurrencyString(amount);
			const int16_t pos_x = center_x;
			const int16_t pos_y = (display.epd2.HEIGHT / 2) - (margin * 3);
			const uint16_t max_w = display.epd2.WIDTH - (margin * 2);
			const Font font = getBestFitFont(text, monospaceFonts, max_w);
			prevText_bbox = renderText(text, font, pos_x, pos_y);
		}
		const float buyLimit = config::getFloat("buyLimit");
		if (buyLimit > 0) {
			std::string text = i18n::t("Limit") + " = ";
			text += util::floatToStringWithPrecision(buyLimit, config::getUnsignedInt("fiatPrecision"));
			text += " " + config::getString("fiatCurrency");
			const int16_t pos_x = center_x;
			const int16_t pos_y = prevText_bbox.y + prevText_bbox.h + margin;
			prevText_bbox = renderText(text, monospaceFontSmall, pos_x, pos_y);
		}
		const float exchangeRate = platform::getExchangeRate();
		if (exchangeRate > 0) {
			std::string text = "1 BTC = ";
			text += util::floatToStringWithPrecision(exchangeRate, config::getUnsignedInt("fiatPrecision"));
			text += " " + config::getString("fiatCurrency");
			const int16_t pos_x = center_x;
			const int16_t pos_y = prevText_bbox.y + prevText_bbox.h + margin;
			prevText_bbox = renderText(text, monospaceFontSmall, pos_x, pos_y);
		}
		{
			// Instructional text #1:
			const std::string text = i18n::t("Insert bills");
			const int16_t pos_x = center_x;
			const int16_t pos_y = prevText_bbox.y + prevText_bbox.h + (margin * 2);
			prevText_bbox = renderText(text, monospaceFontNormal, pos_x, pos_y);
		}
		{
			// Instructional text #2:
			const std::string text = "(" + i18n::t("press button when done") + ")";
			const uint16_t max_w = std::ceil((display.epd2.WIDTH * 4) / 5);
			const Font font = getBestFitFont(text, monospaceFonts, max_w);
			const int16_t pos_x = center_x;
			const int16_t pos_y = prevText_bbox.y + prevText_bbox.h + margin;
			renderText(text, font, pos_x, pos_y);
		}
		finishNewScreen("insertFiat");
	}

	void showTradeCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &t_referencePhrase
	) {
		if (!screen_epaper::isReady()) return;
		logger::write("Show screen: Trade Complete");
		startNewScreen(0/* always scrub */);
		// Margin between rendered elements.
		const int16_t margin = 20;
		const int16_t line_spacing = 8;
		const uint16_t left_screen_w = display.epd2.WIDTH * 0.8;
		BoundingBox instr_text1_bbox;
		{
			// Render instructional text (bottom-left).
			const std::vector<std::string> lines = splitTextIntoLines(i18n::t("Scan with mobile app to redeem and take a picture for your records"), 2);
			const Font font = getBestFitFont(lines[0], monospaceFonts, left_screen_w);
			instr_text1_bbox = calculateTextSize(lines[0], font);
			BoundingBox instr_text2_bbox = calculateTextSize(lines[1], font);
			const int16_t instr_text2_x = margin;// left
			const int16_t instr_text2_y = display.epd2.HEIGHT - (instr_text2_bbox.h + margin);// bottom
			instr_text2_bbox = renderText(lines[1], font, instr_text2_x, instr_text2_y, false);
			const int16_t instr_text1_x = instr_text2_x;// align w/ other text line
			const int16_t instr_text1_y = instr_text2_bbox.y - (instr_text1_bbox.h + (margin / 2));// above other text line
			instr_text1_bbox = renderText(lines[0], font, instr_text1_x, instr_text1_y, false);
		}
		BoundingBox qrcode_bbox;
		{
			// Render QR code (top-left).
			const int16_t qr_x = margin;// left
			const int16_t qr_y = margin;// top
			const uint16_t qr_max_w = left_screen_w - qr_x;
			const uint16_t qr_max_h = display.epd2.HEIGHT - ((display.epd2.HEIGHT - instr_text1_bbox.y) + margin);
			qrcode_bbox = renderQRCode(qrcodeData, qr_x, qr_y, qr_max_w, qr_max_h, false);
		}
		BoundingBox amount_text_bbox;
		{
			// Render amount + fiat currency symbol (top-right).
			const std::string amount_text = getAmountFiatCurrencyString(amount);
			const uint16_t amount_max_w = display.epd2.WIDTH - (qrcode_bbox.x + qrcode_bbox.w + (margin * 2));
			const Font amount_font = getBestFitFont(amount_text, monospaceFonts, amount_max_w);
			amount_text_bbox = calculateTextSize(amount_text, amount_font);
			const int16_t amount_text_x = display.epd2.WIDTH - (amount_text_bbox.w + margin);// right
			const int16_t amount_text_y = qrcode_bbox.y - line_spacing;// top
			amount_text_bbox = renderText(amount_text, amount_font, amount_text_x, amount_text_y, false);
		}
		{
			// Render reference code (bottom-right).
			const std::string referencePhrase = util::toUpperCase(t_referencePhrase);
			std::vector<std::string> words = util::stringListToStringVector(referencePhrase, ' ');
			const std::string deviceReferencePhrase = util::toUpperCase(config::getString("referencePhrase"));
			if (deviceReferencePhrase != "") {
				const std::vector<std::string> deviceWords = util::stringListToStringVector(deviceReferencePhrase, ' ');
				words.insert(words.end(), deviceWords.begin(), deviceWords.end());
			}
			const Font word_font = monospaceFontSmall;
			BoundingBox prev_word_bbox;
			for (int index = 0; index < words.size(); index++) {
				const std::string word = words.at(index);
				const BoundingBox word_bbox = calculateTextSize(word, word_font);
				const int16_t word_x = display.epd2.WIDTH - (word_bbox.w + margin);// right
				int16_t word_y = prev_word_bbox.y + prev_word_bbox.h + line_spacing;
				if (index == 0) {
					word_y += amount_text_bbox.y + amount_text_bbox.h + line_spacing;
				}
				prev_word_bbox = renderText(word, word_font, word_x, word_y, false);
			}
		}
		finishNewScreen("tradeComplete");
	}
}
