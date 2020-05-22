#define STRINGIFY(s) STRINGIFY1(s)
#define STRINGIFY1(s) #s

#ifndef BG_COLOR_HEX
	#define BG_COLOR_HEX "FFFFFF"
#endif

#ifndef TEXT_COLOR_HEX
	#define TEXT_COLOR_HEX "000000"
#endif

#ifndef COIN_ACCEPTOR_PIN
	#define COIN_ACCEPTOR_PIN 4
#endif

#ifndef API_KEY_ID
	#error "Missing required build flag: API_KEY_ID"
#endif

#ifndef API_KEY_SECRET
	#error "Missing required build flag: API_KEY_SECRET"
#endif

#ifndef CALLBACK_URL
	#error "Missing required build flag: CALLBACK_URL"
#endif

#ifndef FIAT_CURRENCY
	#error "Missing required build flag: FIAT_CURRENCY"
#endif

#include <string>
#include "logger.h"

namespace {
	std::string trimQuotes(const std::string &str) {
		return str.substr(1, str.length() - 2);
	}
}

namespace config {
	const uint8_t coinAcceptorPin(COIN_ACCEPTOR_PIN);
	const std::string bgColor(BG_COLOR_HEX);
	const std::string textColor(TEXT_COLOR_HEX);
	const std::string apiKeyId(trimQuotes(STRINGIFY(API_KEY_ID)));
	const std::string apiKeySecret(trimQuotes(STRINGIFY(API_KEY_SECRET)));
	const std::string callbackUrl(trimQuotes(STRINGIFY(CALLBACK_URL)));
	const std::string fiatCurrency(trimQuotes(STRINGIFY(FIAT_CURRENCY)));
	void init();
	float getValueIncrement();
}
