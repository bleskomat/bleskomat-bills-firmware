#include "screen.h"

namespace {

	std::string currentScreen = "";

	void setCurrentScreen(const std::string t_currentScreen) {
		currentScreen = t_currentScreen;
		cache::save("lastScreen", t_currentScreen);
	}
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

	void showSplashScreen() {
		screen_epaper::showSplashScreen();
		setCurrentScreen("splash");
	}

	void showDisabledScreen() {
		screen_epaper::showDisabledScreen();
		setCurrentScreen("disabled");
	}

	void showInstructionsScreen() {
		screen_epaper::showInstructionsScreen();
		setCurrentScreen("instructions");
	}

	void showInsertFiatScreen(const float &amount) {
		screen_epaper::showInsertFiatScreen(amount);
		setCurrentScreen("insertFiat");
		cache::save("accumulatedValue", util::floatToStringWithPrecision(amount, config::getUnsignedShort("fiatPrecision")));
	}

	void showTradeCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &referencePhrase
	) {
		screen_epaper::showTradeCompleteScreen(amount, qrcodeData, referencePhrase);
		setCurrentScreen("tradeComplete");
		cache::save("accumulatedValue", util::floatToStringWithPrecision(amount), "qrcodeData", qrcodeData, "referencePhrase", referencePhrase);
	}

	void showWaitingToConnectScreen() {
		screen_epaper::showWaitingToConnectScreen();
		setCurrentScreen("waitingToConnect");
	}

	std::string getCurrentScreen() {
		return currentScreen;
	}
}
