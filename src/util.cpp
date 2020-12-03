#include "util.h"

namespace {

	std::string generate_nonce() {
		std::ostringstream ss;
		// Random numbers generated by esp_random are probably sufficient.
		// But just to be safe let's append the current time in microseconds as well.
		const auto ms = std::chrono::high_resolution_clock::now().time_since_epoch().count() / 1000;
		ss << esp_random() << "_" << ms;
		return ss.str();
	}
}

namespace util {

	std::string createSignedWithdrawUrl(const double &accumulatedValue) {
		LnurlSigner signer(config::getLnurlSignerConfig());
		const std::string nonce = generate_nonce();
		LnurlWithdrawParamsFiat params;
		params.minWithdrawable = accumulatedValue;
		params.maxWithdrawable = accumulatedValue;
		std::ostringstream defaultDescription;
		defaultDescription << "Bleskomat ATM tranasaction (" << accumulatedValue << " " << config::get("fiatCurrency") + ")";
		params.defaultDescription = defaultDescription.str();
		return signer.create_url(params, nonce);
	}

	std::string lnurlEncode(const std::string &text) {
		return Lnurl::encode(text);
	}

	std::string toUpperCase(std::string s) {
		std::transform(s.begin(), s.end(), s.begin(), [](unsigned char c){ return std::toupper(c); });
		return s;
	}

	std::vector<float> stringListToFloatVector(const std::string &stringList, const char &delimiter) {
		std::vector<float> floatVector;
		if (stringList != "") {
			std::istringstream ss(stringList);
			std::string value;
			while (std::getline(ss, value, delimiter)) {
				floatVector.push_back(std::atof(value.c_str()));
			}
		}
		return floatVector;
	}

	std::string floatVectorToStringList(const std::vector<float> floatVector, const char &delimiter) {
		std::ostringstream ss;
		for (int index = 0; index < floatVector.size(); index++) {
			ss << floatVector[index] << delimiter;
		}
		std::string stringList = ss.str();
		stringList.pop_back();// Remove the last instance of delimiter.
		return stringList;
	}

	std::string floatToString(const float &number) {
		std::ostringstream ss;
		ss << number;
		return ss.str();
	}

	std::string doubleToString(const double &number) {
		std::ostringstream ss;
		ss << number;
		return ss.str();
	}

	std::string unsignedIntToString(const unsigned int &number) {
		std::ostringstream ss;
		ss << +number;
		return ss.str();
	}

	std::string byteToString(const byte &byteIn) {
		std::ostringstream ss;
		ss << +byteIn;
		return ss.str();
	}
}
