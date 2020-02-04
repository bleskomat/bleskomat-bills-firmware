#include "bech32.h"
#include "utilstrencodings.h"
#include <cstdint>
#include <iomanip>
#include <stdexcept>
#include <sstream>
#include <string>

namespace util {
	std::string bech32_encode(const std::string& hrp, const std::string& value);
}
