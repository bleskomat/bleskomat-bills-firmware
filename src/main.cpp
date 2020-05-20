#include <string>
#include "config.h"
#include "display.h"
#include "logger.h"
#include "lnurl.h"
#include "util.h"

const unsigned long bootTime = millis();// milliseconds
const unsigned long minWaitAfterBootTime = 2000;// milliseconds
const unsigned long minWaitTimeBetweenCoins = 7000;// milliseconds
const unsigned long maxTimeDisplayQrCode = 60000;// milliseconds
unsigned long lastCoinInsertedTime = 0;// milliseconds
unsigned long lastRenderedQrCodeTime = 0;// milliseconds
byte previousCoinSignal;
float accumulatedValue = 0.00;

float lastDisplayedAccumulatedValue = 0.00;
unsigned long lastDisplayedAccumulatedValueTime = 0;

void setup() {
  Serial.begin(115200);
  logger::enable();
  config::init();
  logger::write("Config OK");
  display::setBackgroundColor(config::bgColor);
  display::setTextColor(config::textColor);
  display::init();
  logger::write("Display OK");
  pinMode(config::coinAcceptorPin, INPUT_PULLUP);
  previousCoinSignal = digitalRead(config::coinAcceptorPin);
  logger::write("Coin Reader OK");
  logger::write("Setup OK");
}

unsigned long lastSignalChangeTime = 0;
void loop() {
  const byte currentCoinSignal = digitalRead(config::coinAcceptorPin);
  if (currentCoinSignal != previousCoinSignal) {
    previousCoinSignal = currentCoinSignal;
    const unsigned long timeSinceLastSignalChange = millis() - lastSignalChangeTime;
    lastSignalChangeTime = millis();
    if (
      currentCoinSignal == HIGH &&
      millis() - bootTime >= minWaitAfterBootTime &&
      timeSinceLastSignalChange > 25 &&
      timeSinceLastSignalChange < 35
    ) {
      // A coin was inserted.
      // This code executes once for each value unit the coin represents.
      // For example: A coin worth 5 CZK will execute this code 5 times.
      accumulatedValue = accumulatedValue + config::getValueIncrement();
      lastCoinInsertedTime = millis();
      if (lastRenderedQrCodeTime > 0) {
        display::clearQRCode();
        lastRenderedQrCodeTime = 0;
      }
    }
  }
  if (lastRenderedQrCodeTime > 0 && millis() - lastRenderedQrCodeTime >= maxTimeDisplayQrCode) {
    display::clearQRCode();
    lastRenderedQrCodeTime = 0;
  }
  if (lastCoinInsertedTime > 0 && millis() - lastCoinInsertedTime >= minWaitTimeBetweenCoins) {
    // The minimum required wait time between coins has passed.
    // Create a withdraw request and render it as a QR code.
    std::string req = lnurl::create_signed_withdraw_request(
      accumulatedValue,
      config::fiatCurrency,
      config::apiKeyId,
      config::apiKeySecret,
      config::callbackUrl
    );
    display::renderQRCode(req);
    lastRenderedQrCodeTime = millis();
    // Reset accumulated value counter.
    accumulatedValue = 0.00;
    // Reset the last coin inserted time.
    lastCoinInsertedTime = 0;
  }
  if (
    (lastRenderedQrCodeTime == 0) && (
      (lastDisplayedAccumulatedValueTime == 0) ||
      (lastDisplayedAccumulatedValue != accumulatedValue && millis() - lastDisplayedAccumulatedValueTime >= 500)
    )
  ) {
    display::updateAmount(accumulatedValue, config::fiatCurrency);
    lastDisplayedAccumulatedValue = float(accumulatedValue);
    lastDisplayedAccumulatedValueTime = millis();
  }
}
