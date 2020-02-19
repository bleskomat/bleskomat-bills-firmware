#include <SPI.h>
#include "util.h"
#include <string>
#include <TFT_eSPI.h>
#include "qrcode.h"

TFT_eSPI tftScreen = TFT_eSPI();

/*
  Variables for LNURL
*/
char key[] = "";
std::string baseUrl = "https://t1.bleskomat.com/u?";
// !! IMPORTANT !!
// Be sure to urlEncode the API key ID.
std::string id = "";
std::string fiatCurrency = "CZK";
std::string lnurl;

/*
  Variables for Coin Acceptor 616
*/
const byte coinSig = 4;
bool previousCoinSignal = false;
unsigned long previousUpdateMillis = 0;
unsigned long updateInterval = 110;
bool printOnceFlag;
const float coinValue = 1.00;
float bankValue = 0.00;

void setup() {

  tftScreen.begin();
  tftScreen.fillScreen(TFT_WHITE);
  Serial.begin(115200);
  Serial.println("Setting up ...");
  pinMode(coinSig, INPUT_PULLUP);
  previousCoinSignal = digitalRead(coinSig);
}

void loop() {

  byte currentCoinSignal = digitalRead(coinSig);
  if (currentCoinSignal == HIGH) {
    previousUpdateMillis = millis();
    printOnceFlag = true;
  }

  if (printOnceFlag && (millis() - previousUpdateMillis >= updateInterval)) {
    printBankValue();
    printOnceFlag = false;
  }

  if (currentCoinSignal != previousCoinSignal) {
    previousCoinSignal = currentCoinSignal;

    if (currentCoinSignal == HIGH)
      bankValue = bankValue + coinValue;
  }

}

void printBankValue() {

  Serial.println(bankValue);
  create_lnurl();
  Serial.println("lnurl");
  Serial.println(lnurl.c_str());
  showLnurl(lnurl.c_str());
}

void create_lnurl() {
  std::string payload = "";
  payload.append("id=");
  payload.append(id);
  payload.append("&n=");
  payload.append(String(esp_random()).c_str());
  payload.append("&t=w");
  payload.append("&f=");
  payload.append(fiatCurrency);
  payload.append("&pn=");
  payload.append(String(bankValue).c_str());
  payload.append("&px=");
  payload.append(String(bankValue).c_str());
  payload.append("&pd=");

  char payloadToSign[payload.length() + 1];
  std::strcpy(payloadToSign, payload.c_str());

  std::string signature = util::hmac_sign(payloadToSign, key);
  std::string hrp = "lnurl";

  std::string url = "";
  url.append(baseUrl);
  url.append(payload);
  url.append("&s=");
  url.append(signature);

  lnurl = util::bech32_encode(hrp, url);
}

void showLnurl(String lnurl) {

  tftScreen.fillScreen(TFT_WHITE);

  lnurl.toUpperCase();
  const char* data = lnurl.c_str();

  int qrSize = 12;
  int sizes[17] = { 25, 47, 77, 114, 154, 195, 224, 279, 335, 395, 468, 535, 619, 667, 758, 854, 938 };
  int len = String(data).length();
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
        tftScreen.fillRect(15+3+scale*x, 15+3+scale*y, scale, scale, TFT_BLACK);
      }
      else {
        tftScreen.fillRect(15+3+scale*x, 15+3+scale*y, scale, scale, TFT_WHITE);
      }
    }
  }
}
