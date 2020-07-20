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

namespace modules {
	void init();
	void loop();
}
