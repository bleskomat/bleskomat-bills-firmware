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
		screen::init();
		logger::write("Screen OK");
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

	void enableAcceptors() {
		#ifdef COIN_ACCEPTOR
			coinAcceptor::on();
		#endif
		#ifdef BILL_ACCEPTOR
			billAcceptor::on();
		#endif
	}

	void disableAcceptors() {
		#ifdef COIN_ACCEPTOR
			coinAcceptor::off();
		#endif
		#ifdef BILL_ACCEPTOR
			billAcceptor::off();
		#endif
	}
}
