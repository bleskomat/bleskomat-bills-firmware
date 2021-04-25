#ifndef BLESKOMAT_MODULES_DUMMY_SCREEN_H
#define BLESKOMAT_MODULES_DUMMY_SCREEN_H

#include "logger.h"

#include <string>

namespace screen {
	void init();
	std::string getCurrentScreen();
	void showSplashScreen();
	void showInstructionsScreen();
	void showInsertFiatScreen(const float &amount);
	void updateInsertFiatScreenAmount(const float &amount);
	void showTransactionCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &referenceCode = ""
	);
	void showWifiAccessPointConnectionDetailsScreen(
		const std::string &ssid,
		const std::string &password,
		const std::string &configurationString
	);
	void showWifiAccessPointOpenWebInterfaceScreen(const std::string &url);
}

#endif
