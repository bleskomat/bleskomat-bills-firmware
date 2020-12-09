#include "modules.h"

namespace modules {

	void init() {
		#ifdef COIN_ACCEPTOR
			coinAcceptor::init();
			logger::write("Coin Reader OK");
		#endif
		#ifdef BILL_ACCEPTOR
			billAcceptor::init();
			logger::write("Bill Reader OK");
		#endif
		#ifdef BUTTON
			button::init();
			logger::write("Button OK");
		#endif
		#ifdef EPAPER
			screen::init();
			logger::write("Screen OK");
		#endif
	}

	void loop() {
		#ifdef COIN_ACCEPTOR
			coinAcceptor::loop();
		#endif
		#ifdef BILL_ACCEPTOR
			billAcceptor::loop();
		#endif
		#ifdef BUTTON
			button::loop();
		#endif
	}
}
