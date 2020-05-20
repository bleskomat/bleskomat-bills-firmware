#include "SPI.h"
#include "TFT_eSPI.h"
#include <iostream>
#include "lnurl.h"
#include <sstream>
#include <string>
#include "qrcode.h"
#include "util.h"
#include "config.h"

TFT_eSPI tft = TFT_eSPI();

const unsigned long bootTime = millis();// milliseconds
const unsigned long minWaitAfterBootTime = 2000;// milliseconds
const unsigned long minWaitTimeBetweenCoins = 7000;// milliseconds
const unsigned long maxTimeDisplayQrCode = 60000;// milliseconds
unsigned long lastCoinInsertedTime = 0;// milliseconds
unsigned long lastDisplayedQrCodeTime = 0;// milliseconds
byte previousCoinSignal;
float accumulatedValue = 0.00;
// The amount by which to increase the internal accumulated fiat value for each signal from the coin acceptor:
float valueIncrement;
int BG_COLOR;
int TEXT_COLOR;

const uint8_t baseFontCharWidth = 6;
const uint8_t baseFontCharHeight = 8;
const uint8_t accumulatedValue_textSize = 2;
const uint8_t accumulatedValue_displayedTextHeight = baseFontCharHeight * accumulatedValue_textSize;
float lastDisplayedAccumulatedValue = 0.00;
unsigned long lastDisplayedAccumulatedValueTime = 0;

void clear_accumulated_value() {
  Serial.println("Clearing accumulated value...");
  // Clear previous text by drawing a white rectangle over it.
  tft.fillRect(0, accumulatedValue_displayedTextHeight, tft.width(), accumulatedValue_displayedTextHeight, BG_COLOR);
  lastDisplayedAccumulatedValue = 0.00;
  lastDisplayedAccumulatedValueTime = 0;
}

void display_accumulated_value() {
  clear_accumulated_value();
  Serial.println("Displaying accumulated value...");
  std::ostringstream fiat;
  fiat << accumulatedValue << " " << config::fiatCurrency;
  const std::string str = fiat.str();
  const char* text = str.c_str();
  const uint8_t displayedTextWidth = baseFontCharWidth * accumulatedValue_textSize * str.length();
  tft.setTextSize(accumulatedValue_textSize);
  tft.setTextColor(TEXT_COLOR);
  tft.setCursor((tft.width() - displayedTextWidth) / 2, accumulatedValue_displayedTextHeight);
  tft.println(text);
  lastDisplayedAccumulatedValue = float(accumulatedValue);
  lastDisplayedAccumulatedValueTime = millis();
}

void update_displayed_accumulated_value() {
  if (
    (lastDisplayedQrCodeTime == 0) && (
      (lastDisplayedAccumulatedValueTime == 0) ||
      (lastDisplayedAccumulatedValue != accumulatedValue && millis() - lastDisplayedAccumulatedValueTime >= 500)
    )
  ) {
    display_accumulated_value();
  }
}

const uint8_t qrcode_width = 98;
const uint8_t qrcode_height = 98;
const uint8_t qrcode_offsetX = (tft.width() - qrcode_width) / 2;
const uint8_t qrcode_offsetY = accumulatedValue_displayedTextHeight * 3;

void clear_qrcode() {
  Serial.println("Clearing QR code...");
  tft.fillRect(qrcode_offsetX, qrcode_offsetY, qrcode_width, qrcode_height, BG_COLOR);
  lastDisplayedQrCodeTime = 0;
}

std::string str_toupper(std::string s) {
  std::transform(s.begin(), s.end(), s.begin(), [](unsigned char c){ return std::toupper(c); });
  return s;
}

void display_qrcode(const std::string &dataStr) {
  clear_qrcode();
  Serial.println("Displaying QR code...");
  const char* data = str_toupper(dataStr).c_str();
  int qrSize = 12;
  int sizes[17] = { 25, 47, 77, 114, 154, 195, 224, 279, 335, 395, 468, 535, 619, 667, 758, 854, 938 };
  int len = std::string(data).length();
  for (int i = 0; i < 17; i++) {
    if (sizes[i] > len) {
      qrSize = i + 1;
      break;
    }
  }
  QRCode qrcode;
  uint8_t qrcodeData[qrcode_getBufferSize(qrSize)];
  qrcode_initText(&qrcode, qrcodeData, qrSize, ECC_LOW, data);
  float scale = 2;
  for (uint8_t y = 0; y < qrcode.size; y++) {
    for (uint8_t x = 0; x < qrcode.size; x++) {
      if (qrcode_getModule(&qrcode, x, y)) {
        tft.fillRect(qrcode_offsetX + scale*x, qrcode_offsetY + scale*y, scale, scale, TEXT_COLOR);
      } else {
        tft.fillRect(qrcode_offsetX + scale*x, qrcode_offsetY + scale*y, scale, scale, BG_COLOR);
      }
    }
  }
  lastDisplayedQrCodeTime = millis();
}

void generate_and_display_withdraw_request() {
  std::string req = lnurl::create_signed_withdraw_request(
    accumulatedValue,
    config::fiatCurrency,
    config::apiKeyId,
    config::apiKeySecret,
    config::callbackUrl
  );
  std::ostringstream msg;
  msg << "LNURL: " << req;
  std::cout << msg.str() << '\n';
  display_qrcode(req);
}

void setup() {
  Serial.begin(115200);
  Serial.println("Setting up...");
  Serial.println("Serial ready");
  BG_COLOR = util::hex_to_rgb565(config::bgColor);
  TEXT_COLOR = util::hex_to_rgb565(config::textColor);
  tft.begin();
  tft.fillScreen(BG_COLOR);
  Serial.println("Screen ready");
  pinMode(config::coinAcceptorPin, INPUT_PULLUP);
  previousCoinSignal = digitalRead(config::coinAcceptorPin);
  Serial.println("Coin reader ready");
  std::cout << "config::apiKeyId=" << config::apiKeyId << '\n';
  std::cout << "config::apiKeySecret=" << config::apiKeySecret << '\n';
  std::cout << "config::callbackUrl=" << config::callbackUrl << '\n';
  std::cout << "config::fiatCurrency=" << config::fiatCurrency << '\n';
  std::cout << "config::bgColor=" << config::bgColor << '\n';
  std::cout << "config::textColor=" << config::textColor << '\n';
  if (config::fiatCurrency == "EUR") {
    valueIncrement = 0.05;
  } else {
    valueIncrement = 1.0;
  }
  std::cout << "valueIncrement=" << valueIncrement << '\n';
  Serial.println("Setup complete!");
}

unsigned long lastSignalChangeTime = 0;
void loop() {
  const byte currentCoinSignal = digitalRead(config::coinAcceptorPin);
  if (currentCoinSignal != previousCoinSignal) {
    previousCoinSignal = currentCoinSignal;
    const unsigned long timeSinceLastSignalChange = millis() - lastSignalChangeTime;
    lastSignalChangeTime = millis();
//    if (currentCoinSignal == HIGH) {
//      Serial.println("HIGH");
//    } else if (currentCoinSignal == LOW) {
//      Serial.println("LOW");
//    }
//    std::ostringstream msg2;
//    msg2 << "LAST SIGNAL CHANGE WAS " << timeSinceLastSignalChange << " ms AGO";
//    std::cout << msg2.str() << '\n';
    if (
      currentCoinSignal == HIGH &&
      millis() - bootTime >= minWaitAfterBootTime &&
      timeSinceLastSignalChange > 25 &&
      timeSinceLastSignalChange < 35
    ) {
      // A coin was inserted.
      // This code executes once for each value unit the coin represents.
      // For example: A coin worth 5 CZK will execute this code 5 times.
      accumulatedValue = accumulatedValue + valueIncrement;
//      std::ostringstream msg;
//      msg << "ACCUMULATED VALUE: " << accumulatedValue;
//      std::cout << msg.str() << '\n';
      lastCoinInsertedTime = millis();
      if (lastDisplayedQrCodeTime > 0) {
        clear_qrcode();
      }
    }
  }
  if (lastDisplayedQrCodeTime > 0 && millis() - lastDisplayedQrCodeTime >= maxTimeDisplayQrCode) {
    clear_qrcode();
  }
  if (lastCoinInsertedTime > 0 && millis() - lastCoinInsertedTime >= minWaitTimeBetweenCoins) {
    // The minimum required wait time between coins has passed.
    generate_and_display_withdraw_request();
    // Reset accumulated value counter.
    accumulatedValue = 0.00;
    // Reset the last coin inserted time.
    lastCoinInsertedTime = 0;
  }
  update_displayed_accumulated_value();
}