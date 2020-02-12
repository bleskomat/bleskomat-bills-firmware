#include "bech32.h"
#include "utilstrencodings.h"
#include <cstdint>
#include <iomanip>
#include <stdexcept>
#include <sstream>
#include <string>
#include "mbedtls/md.h"
#include <cstring>
#include <stdio.h>

namespace util {
	std::string bech32_encode(const std::string& hrp, const std::string& value);
	std::string hmac_sign(char* payload, char* key);
}
