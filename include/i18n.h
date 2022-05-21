#ifndef BLESKOMAT_I18N_H
#define BLESKOMAT_I18N_H

#include "config.h"

#include <cstring>
#include <map>
#include <string>

namespace i18n {
	typedef std::map<const char*, const char*> Locale;
	std::string t(const char* key);
	std::string t(const char* key, const char* locale);
}

#include "locale/cs.h"
#include "locale/de.h"
#include "locale/en.h"
#include "locale/es.h"

#endif
