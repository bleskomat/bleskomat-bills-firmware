#include "config.h"

namespace config {

	void init() {
		logger::write("apiKeyId: " + apiKeyId);
		logger::write("apiKeySecret: " + apiKeySecret);
		logger::write("callbackUrl: " + callbackUrl);
		logger::write("fiatCurrency: " + fiatCurrency);
		logger::write("bgColor: " + bgColor);
		logger::write("textColor: " + textColor);
	}

	float getValueIncrement() {
		float valueIncrement;
		if (fiatCurrency == "EUR") {
			valueIncrement = 0.05;
		} else {
			valueIncrement = 1.0;
		}
		return valueIncrement;
	}
}
