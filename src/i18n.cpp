#include "i18n.h"

namespace {

	// This is needed to use char* as key in std::map.
	struct cmp_str {
		bool operator()(char const *a, char const *b) const {
			return std::strcmp(a, b) < 0;
		}
	};

	const std::map<const char*, const i18n::Locale*, cmp_str> locales {
		{ "cs", &locale_cs },
		{ "de", &locale_de },
		{ "en", &locale_en },
		{ "es", &locale_es }
	};

	const char* defaultLocale = "en";
}

namespace i18n {

	std::string t(const char* key) {
		return t(key, config::getString("locale").c_str());
	}

	std::string t(const char* key, const char* locale) {
		if (locales.count(locale) > 0) {
			const i18n::Locale* strings = locales.at(locale);
			if (strings->count(key) > 0) {
				// Locale has key defined.
				return std::string(strings->at(key));
			} else if (locale != defaultLocale) {
				// Try the default locale.
				return t(key, defaultLocale);
			}
		}
		return std::string(key);
	}
}
