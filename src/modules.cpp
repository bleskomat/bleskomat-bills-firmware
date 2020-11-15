#include "modules.h"

namespace modules {

	void init() {
		#ifdef COIN_ACCEPTOR
			coinAcceptor::init();
			coinAcceptor::setFiatCurrency(config::getConfig().fiatCurrency);
			logger::write("Coin Reader OK");
		#endif
		#ifdef BILL_ACCEPTOR
			billAcceptor::init();
			billAcceptor::setFiatCurrency(config::getConfig().fiatCurrency);
			logger::write("Bill Reader OK");
		#endif
		#ifdef BUTTON
			button::init();
			logger::write("Button OK");
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
