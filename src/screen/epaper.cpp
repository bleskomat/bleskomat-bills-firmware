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

	bool initialized = false;

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
		u8g2_courier_prime_code_12pt,
		u8g2_courier_prime_code_10pt,
		u8g2_courier_prime_code_8pt
	};

	FontList brandFonts = {
		// Ordered from largest (top) to smallest (bottom).
		u8g2_checkbook_48pt,
		u8g2_checkbook_44pt,
		u8g2_checkbook_40pt,
		u8g2_checkbook_36pt,
		u8g2_checkbook_32pt,
		u8g2_checkbook_28pt,
		u8g2_checkbook_24pt,
		u8g2_checkbook_20pt,
		u8g2_checkbook_16pt
	};

	FontList proportionalFonts = {
		// Ordered from largest (top) to smallest (bottom).
		u8g2_opensans_light_18pt,
		u8g2_opensans_light_16pt,
		u8g2_opensans_light_14pt,
		u8g2_opensans_light_12pt,
		u8g2_opensans_light_10pt,
		u8g2_opensans_light_8pt
	};

	Font monospaceFontSmall = u8g2_courier_prime_code_12pt;
	Font monospaceFontNormal = u8g2_courier_prime_code_16pt;
	Font proportionalFontSmall = u8g2_opensans_light_12pt;
	Font proportionalFontNormal = u8g2_opensans_light_16pt;

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
		return fonts.at(fonts.size() - 1);
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

	void activate() {
		// It is necessary to unmount the SD card before using another SPI device.
		sdcard::unmount();
		SPI.end();
		SPI.begin(EPAPER_CLK, EPAPER_MISO, EPAPER_DIN, EPAPER_CS);
	}

	void deactivate() {
		// Stop using SPI here and re-mount the SD card.
		SPI.end();
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
		activate();
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
		deactivate();
	}

	std::string getInstructionsUrl() {
		const std::string apiKeyId = config::getString("apiKey.id");
		std::string instructionsUrl = config::getString("webUrl");
		instructionsUrl += "/intro?id=" + util::urlEncode(apiKeyId);
		return instructionsUrl;
	}
}

namespace screen_epaper {

	void init() {}

	void loop() {
		if (!initialized) {
			initialized = true;
			logger::write("Initializing e-paper display...");
			if (display.epd2.panel == GxEPD2::GDEW042T2) {
				display.init(0);
				u8g2Fonts.begin(display);// connect u8g2 procedures to Adafruit GFX
				activate();
				display.setRotation(0);
				deactivate();
			} else {
				logger::write("Unknown display connected. This device supports WaveShare 4.2 inch e-paper b/w");
			}
		}
	}

	bool isReady() {
		return initialized;
	}

	void debugCommands() {
		// Uncomment the following lines to render each screen after a short delay between each.
		// epaper::showSplashScreen();
		// delay(2000);
		// epaper::showDisabledScreen();
		// delay(2000);
		// epaper::showInstructionsScreen();
		// delay(2000);
		// epaper::showInsertFiatScreen(100.00);
		// delay(2000);
		// const float amount = 100.00;
		// const std::string referencePhrase = util::generateRandomPhrase(5);
		// Lnurl::Query customParams;
		// customParams["r"] = referencePhrase;
		// const float exchangeRate = 38000.441;
		// if (exchangeRate > 0) {
		// 	customParams["er"] = std::to_string(exchangeRate);
		// }
		// const std::string qrcodeData = config::getString("uriSchemaPrefix") + util::toUpperCase(util::lnurlEncode(util::createSignedLnurlWithdraw(amount, customParams)));
		// epaper::showTradeCompleteScreen(amount, qrcodeData, referencePhrase);
	}

	void showSplashScreen() {
		if (!initialized) return;
		logger::write("Show screen: Splash");
		startNewScreen();
		const int16_t margin = 24;
		BoundingBox prevText_bbox;
		{
			const std::string title = "BLESKOMAT";
			int16_t title_x = (display.epd2.WIDTH / 2);// center
			int16_t title_y = (display.epd2.HEIGHT / 2) - (margin * 2);
			const Font title_font = getBestFitFont(title, brandFonts);
			prevText_bbox = renderText(title, title_font, title_x, title_y);
		}
		{
			const std::string slogan_line1 = "WHERE WE'RE GOING,";
			int16_t slogan_line1_x = (display.epd2.WIDTH / 2);// center
			int16_t slogan_line1_y = prevText_bbox.y + prevText_bbox.h + margin;
			const Font slogan_line1_font = getBestFitFont(slogan_line1, brandFonts, display.epd2.WIDTH * .6);
			prevText_bbox = renderText(slogan_line1, slogan_line1_font, slogan_line1_x, slogan_line1_y);
		}
		{
			const std::string slogan_line2 = "WE DON'T NEED BANKS";
			int16_t slogan_line2_x = (display.epd2.WIDTH / 2);// center
			int16_t slogan_line2_y = prevText_bbox.y + prevText_bbox.h + margin;
			const Font slogan_line2_font = getBestFitFont(slogan_line2, brandFonts, display.epd2.WIDTH * .65);
			prevText_bbox = renderText(slogan_line2, slogan_line2_font, slogan_line2_x, slogan_line2_y);
		}
		const std::string instructions = i18n::t("splash_instructions");
		const BoundingBox instructions_bbox = calculateTextSize(instructions, proportionalFontNormal);
		int16_t instructions_x = display.epd2.WIDTH / 2;// center
		int16_t instructions_y = display.epd2.HEIGHT - (instructions_bbox.h + margin);// bottom
		renderText(instructions, proportionalFontNormal, instructions_x, instructions_y);
		finishNewScreen("splash");
	}

	void showDisabledScreen() {
		if (!initialized) return;
		logger::write("Show screen: Disabled");
		startNewScreen();
		const int16_t margin = 24;
		const std::string text = i18n::t("disabled_heading");
		const int16_t text_x = (display.epd2.WIDTH / 2);// center
		const int16_t text_y = (display.epd2.HEIGHT / 2) - margin;
		const Font font = getBestFitFont(text, monospaceFonts);
		const BoundingBox text_bbox = renderText(text, font, text_x, text_y);
		const std::string text2 = i18n::t("disabled_subheading");
		const int16_t text2_x = display.epd2.WIDTH / 2;// center
		const int16_t text2_y = text_bbox.h + text_bbox.y + margin;// bottom
		renderText(text2, proportionalFontSmall, text2_x, text2_y);
		finishNewScreen("disabled");
	}

	void showInstructionsScreen() {
		if (!initialized) return;
		logger::write("Show screen: Instructions");
		startNewScreen();
		const std::string instructionsUrl = getInstructionsUrl();
		const int16_t margin = 24;
		const int16_t line_spacing = 8;
		const uint16_t qrcode_w = 100;
		const uint16_t qrcode_h = 100;
		const int16_t qrcode_x = margin;
		const int16_t qrcode_y = margin;
		BoundingBox qrcode_bbox = renderQRCode(instructionsUrl, qrcode_x, qrcode_y, qrcode_w, qrcode_h, false);
		{
			const std::string text1 = i18n::t("instructions_qr_text1");
			const std::string text2 = i18n::t("instructions_qr_text2");
			const std::string text3 = i18n::t("instructions_qr_text3");
			int16_t text1_x = qrcode_bbox.x + qrcode_bbox.w + margin;// right of the QR code
			int16_t text1_y = qrcode_bbox.y;// align w/ QR code
			const int16_t max_w = display.epd2.WIDTH - (text1_x + margin);
			const int16_t max_h = (qrcode_bbox.h - (line_spacing * 2)) / 4;
			const Font text1_font = getBestFitFont(text1, proportionalFonts, max_w, max_h);
			BoundingBox prevText_bbox;
			prevText_bbox = renderText(text1, text1_font, text1_x, text1_y, false);
			int16_t text2_y = prevText_bbox.y + prevText_bbox.h + line_spacing;
			prevText_bbox = renderText(text2, text1_font, text1_x, text2_y, false);
			int16_t text3_y = prevText_bbox.y + prevText_bbox.h + line_spacing;
			renderText(text3, text1_font, text1_x, text3_y, false);
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
			const std::string text4 = i18n::t("instructions_step1_text");
			const std::string text5 = i18n::t("instructions_step2_text");
			const std::string text6 = i18n::t("instructions_step3_text");
			const std::string text7 = i18n::t("instructions_step4_text");
			const Font text4_font = u8g2_opensans_light_12pt;
			int16_t text4_x = numbering1_bbox.x + numbering1_bbox.w + line_spacing;// left, next to the numbering
			int16_t text4_y = numbering1_bbox.y;// align w/ first number
			renderText(text4, text4_font, text4_x, text4_y, false);
			int16_t text5_y = numbering2_bbox.y;// align w/ second number
			renderText(text5, text4_font, text4_x, text5_y, false);
			int16_t text6_y = numbering3_bbox.y;// align w/ third number
			renderText(text6, text4_font, text4_x, text6_y, false);
			int16_t text7_y = numbering4_bbox.y;// align w/ fourth number
			renderText(text7, text4_font, text4_x, text7_y, false);
		}
		finishNewScreen("instructions");
	}

	void showInsertFiatScreen(const float &amount) {
		if (!initialized) return;
		logger::write("Show screen: Insert Fiat");
		startNewScreen();
		const int16_t margin = 24;
		const int16_t center_x = display.epd2.WIDTH / 2;// center
		BoundingBox prevText_bbox;
		{
			// Render amount + fiat currency symbol (top-center).
			const std::string amount_text = getAmountFiatCurrencyString(amount);
			const int16_t amount_x = center_x;
			const int16_t amount_y = (display.epd2.HEIGHT / 2) - (margin * 3);
			const uint16_t amount_max_w = display.epd2.WIDTH - (margin * 2);
			const Font amount_font = getBestFitFont(amount_text, monospaceFonts, amount_max_w);
			prevText_bbox = renderText(amount_text, amount_font, amount_x, amount_y);
		}
		const float buyLimit = config::getFloat("buyLimit");
		if (buyLimit > 0) {
			std::string limitText = i18n::t("insert_fiat_limit") + " = ";
			limitText += util::floatToStringWithPrecision(buyLimit, config::getUnsignedInt("fiatPrecision"));
			limitText += " " + config::getString("fiatCurrency");
			const int16_t limitText_y = prevText_bbox.y + prevText_bbox.h + margin;
			prevText_bbox = renderText(limitText, monospaceFontNormal, center_x, limitText_y);
		}
		const float exchangeRate = platform::getExchangeRate();
		if (exchangeRate > 0) {
			std::string exchangeRateText = "1 BTC = ";
			exchangeRateText += util::floatToStringWithPrecision(exchangeRate, config::getUnsignedInt("fiatPrecision"));
			exchangeRateText += " " + config::getString("fiatCurrency");
			const int16_t exchangeRateText_y = prevText_bbox.y + prevText_bbox.h + margin;
			prevText_bbox = renderText(exchangeRateText, monospaceFontNormal, center_x, exchangeRateText_y);
		}
		// Instructional text #1:
		const std::string text1 = i18n::t("insert_fiat_instructions_line1");
		const int16_t text1_y = prevText_bbox.y + prevText_bbox.h + (margin * 2);
		prevText_bbox = renderText(text1, proportionalFontNormal, center_x, text1_y);
		// Instructional text #2:
		const std::string text2 = i18n::t("insert_fiat_instructions_line2");
		const int16_t text2_y = prevText_bbox.y + prevText_bbox.h + margin;
		prevText_bbox = renderText(text2, proportionalFontSmall, center_x, text2_y);
		finishNewScreen("insertFiat");
	}

	void showTradeCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &t_referencePhrase
	) {
		if (!initialized) return;
		logger::write("Show screen: Trade Complete");
		startNewScreen(0/* always scrub */);
		// Margin between rendered elements.
		const int16_t margin = 24;
		const int16_t line_spacing = 8;
		const uint16_t left_screen_w = display.epd2.WIDTH * 0.8;
		BoundingBox instr_text1_bbox;
		{
			// Render instructional text (bottom-left).
			const std::string instr_text1 = i18n::t("trade_complete_instructions_line1");
			const std::string instr_text2 = i18n::t("trade_complete_instructions_line2");
			const Font instr_font = proportionalFontSmall;
			instr_text1_bbox = calculateTextSize(instr_text1, instr_font);
			BoundingBox instr_text2_bbox = calculateTextSize(instr_text2, instr_font);
			const int16_t instr_text2_x = margin;// left
			const int16_t instr_text2_y = display.epd2.HEIGHT - (instr_text2_bbox.h + margin);// bottom
			instr_text2_bbox = renderText(instr_text2, instr_font, instr_text2_x, instr_text2_y, false);
			const int16_t instr_text1_x = instr_text2_x;// align w/ other text line
			const int16_t instr_text1_y = instr_text2_bbox.y - (instr_text1_bbox.h + (margin / 2));// above other text line
			instr_text1_bbox = renderText(instr_text1, instr_font, instr_text1_x, instr_text1_y, false);
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
