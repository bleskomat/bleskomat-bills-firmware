#ifndef BLESKOMAT_MODULES_EPAPER_H
#define BLESKOMAT_MODULES_EPAPER_H

#include "fonts/OpenSans_Light9pt7b.h"
#include "fonts/OpenSans_Light12pt7b.h"
#include "fonts/Courier_Prime_Code12pt7b.h"
#include "fonts/Courier_Prime_Code16pt7b.h"
#include "fonts/Courier_Prime_Code20pt7b.h"
#include "fonts/Courier_Prime_Code22pt7b.h"
#include "fonts/Courier_Prime_Code24pt7b.h"
#include "fonts/Courier_Prime_Code26pt7b.h"
#include "fonts/Courier_Prime_Code28pt7b.h"
#include "fonts/Courier_Prime_Code30pt7b.h"
#include "fonts/Courier_Prime_Code32pt7b.h"

#include "images/bleskomat_instructions_screen_400x300.h"
#include "images/bleskomat_splash_screen_400x300.h"

#include "config.h"
#include "logger.h"
#include "util.h"

#ifndef EPAPER_CLK
#define EPAPER_CLK 13
#endif

#ifndef EPAPER_MISO
#define EPAPER_MISO 12
#endif

#ifndef EPAPER_DIN
#define EPAPER_DIN 14
#endif

#ifndef EPAPER_CS
#define EPAPER_CS 15
#endif

#ifndef EPAPER_DC
#define EPAPER_DC 27
#endif

#ifndef EPAPER_RST
#define EPAPER_RST 26
#endif

#ifndef EPAPER_BUSY
#define EPAPER_BUSY 25
#endif

#define ENABLE_GxEPD2_GFX 0

#include <Arduino.h>
#include <qrcode.h>
#include <Wire.h>
#include <GxEPD2_GFX.h>
#include <GxEPD2_BW.h>

#include <vector>

namespace epaper {
	void init();
	std::string getCurrentScreen();
	void showSplashScreen();
	void showInstructionsScreen();
	void showInsertFiatScreen(const float &amount);
	void updateInsertFiatScreenAmount(const float &amount);
	void showTransactionCompleteScreen(const float &amount, const std::string &qrcodeData);
}

namespace screen = epaper;

#endif
