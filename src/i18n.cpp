#include "i18n.h"

namespace i18n {

	std::map<std::string, Locale> locales {
		{ "cs", locale_cs },
		{ "en", locale_en },
		{ "es", locale_es }
	};

	std::string defaultLocale = "en";

	std::string t(const std::string &key) {
		return i18n::t(key, config::get("locale"));
	}

	std::string t(const std::string &key, const std::string &locale) {
		std::string text = key;
		if (locales.find(locale) != locales.end()) {
			const Locale strings = locales.at(locale);
			if (strings.find(key) == strings.end()) {
				// Locale does not have the key defined.
				if (locale != defaultLocale) {
					// Try the default locale.
					text = i18n::t(key, defaultLocale);
				}
			} else {
				// Locale has key defined.
				text = strings.at(key);
			}
		}
		return text;
	}
}
