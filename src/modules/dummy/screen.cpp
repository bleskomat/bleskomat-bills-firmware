#include "modules/dummy/screen.h"

// Dummy implementation of screen module.
// This module does nothing.

namespace {
	std::string currentScreen = "";
}

namespace screen {

	void init() {
		logger::write("Dummy screen module initialized");
	}

	std::string getCurrentScreen() {
		return currentScreen;
	}

	void showSplashScreen() {
		currentScreen = "splash";
	}

	void showInstructionsScreen() {
		currentScreen = "instructions";
	}

	void showInsertFiatScreen(const float &amount) {
		currentScreen = "insertFiat";
	}

	void updateInsertFiatScreenAmount(const float &amount) {}

	void showTransactionCompleteScreen(
		const float &amount,
		const std::string &qrcodeData,
		const std::string &referencePhrase
	) {
		currentScreen = "transactionComplete";
	}
}
