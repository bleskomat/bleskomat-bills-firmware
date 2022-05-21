#include "screen.h"

namespace {
	std::string currentScreen = "";
}

namespace screen {

	void init() {
		screen_epaper::init();
	}

	void loop() {
		screen_epaper::loop();
	}

	bool isReady() {
		return screen_epaper::isReady();
	}

	void debugCommands() {
		screen_epaper::debugCommands();
	}

	void showSplashScreen() {
		screen_epaper::showSplashScreen();
		currentScreen = "splash";
	}

	void showDisabledScreen() {
		screen_epaper::showDisabledScreen();
		currentScreen = "disabled";
	}

	void showInstructionsScreen() {
		screen_epaper::showInstructionsScreen();
		currentScreen = "instructions";
	}

	void showInsertFiatScreen(const float &amount) {
		screen_epaper::showInsertFiatScreen(amount);
		currentScreen = "insertFiat";
	}

	void showTradeCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &referencePhrase
	) {
		screen_epaper::showTradeCompleteScreen(amount, qrcodeData, referencePhrase);
		currentScreen = "tradeComplete";
	}

	std::string getCurrentScreen() {
		return currentScreen;
	}
}
