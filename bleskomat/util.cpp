#include "util.h"

namespace {
	std::string string_to_hex(const std::string& in) {
		std::stringstream ss;
		ss << std::hex << std::setfill('0');
		for (size_t i = 0; in.length() > i; ++i) {
			ss << std::setw(2) << static_cast<unsigned int>(static_cast<unsigned char>(in[i]));
		}
		return ss.str();
	}
}

namespace std {
	enum class byte : unsigned char {};
}

namespace util {
	std::string bech32_encode(const std::string& hrp, const std::string& value) {
		std::vector<uint8_t> v = ParseHex(string_to_hex(value));
		std::vector<unsigned char> tmp = {};
		tmp.reserve(1 + 32 * 8 / 5);
		ConvertBits<8, 5, true>([&](unsigned char c) { tmp.push_back(c); }, v.begin(), v.end());
		std::string s(v.begin(), v.end());
		return bech32::encode(hrp, tmp);
	}

	std::string hmac_sign(char* payload, char* key) {
		std::string result = "";
		unsigned char hmacResult[32];

		mbedtls_md_context_t ctx;
		mbedtls_md_type_t md_type = MBEDTLS_MD_SHA256;

		const size_t payloadLength = std::strlen(payload);
		const size_t keyLength = std::strlen(key);

		mbedtls_md_init(&ctx);
		mbedtls_md_setup(&ctx, mbedtls_md_info_from_type(md_type), 1);
		mbedtls_md_hmac_starts(&ctx, (const unsigned char *) key, keyLength);
		mbedtls_md_hmac_update(&ctx, (const unsigned char *) payload, payloadLength);
		mbedtls_md_hmac_finish(&ctx, hmacResult);
		mbedtls_md_free(&ctx);

		for (int i = 0; i < sizeof(hmacResult); i++) {
			char str[3];

			sprintf(str, "%02x", (int)hmacResult[i]);

			result.append(str);
		}

		return result;
	}
}
