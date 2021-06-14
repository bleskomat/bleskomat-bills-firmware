#ifndef BLESKOMAT_MODULES_DUMMY_SCREEN_H
#define BLESKOMAT_MODULES_DUMMY_SCREEN_H

#include "logger.h"

#include <string>

namespace screen {
	void init();
	std::string getCurrentScreen();
	void showSplashScreen();
	void showDisabledScreen();
	void showInstructionsScreen();
	void showInsertFiatScreen(const float &amount);
	void showTradeCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &referencePhrase = ""
	);
}

#endif
