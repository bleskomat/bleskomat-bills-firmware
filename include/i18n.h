#ifndef BLESKOMAT_I18N_H
#define BLESKOMAT_I18N_H

#include "config.h"

#include <map>
#include <string>

namespace i18n {
	typedef std::map<std::string, std::string> Locale;
	std::string t(const std::string &key);
	std::string t(const std::string &key, const std::string &locale);
}

#include "locale/cs.h"
#include "locale/de.h"
#include "locale/en.h"
#include "locale/es.h"

#endif
