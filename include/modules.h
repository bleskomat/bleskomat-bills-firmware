#ifndef BLESKOMAT_MODULES_H
#define BLESKOMAT_MODULES_H

#include "config.h"
#include "logger.h"

#ifdef COIN_ACCEPTOR
	#include "modules/coin-acceptor.h"
#endif

#ifdef BILL_ACCEPTOR
	#include "modules/bill-acceptor.h"
#endif

#ifdef BUTTON
	#include "modules/button.h"
#endif

#ifdef EPAPER
	#include "modules/epaper.h"
	namespace screen = epaper;
#else
	#include "modules/dummy/screen.h"
#endif

namespace modules {
	void init();
	void loop();
	void enableAcceptors();
	void disableAcceptors();
}

#endif
