#include "config.h"

namespace config {

	void init() {
		logger::write("apiKeyId: " + apiKeyId);
		logger::write("apiKeySecret: " + apiKeySecret);
		logger::write("callbackUrl: " + callbackUrl);
		logger::write("fiatCurrency: " + fiatCurrency);
	}
}
