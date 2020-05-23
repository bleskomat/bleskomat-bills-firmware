#include "esp_system.h"
#include "mbedtls/md.h"
#include "bech32.h"
#include <cstring>
#include <iomanip>
#include <sstream>
#include <string>
#include "utilstrencodings.h"

namespace lnurl {
	std::string create_signed_withdraw_request(
		const float &amount,
		const std::string &fiatCurrency,
		const std::string &apiKeyId,
		const std::string &apiKeySecret,
		const std::string &callbackUrl
	);
}
