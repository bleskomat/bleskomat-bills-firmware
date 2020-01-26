#include <SPI.h>
#include "mbedtls/md.h"
#include <string>
#include <TFT_eSPI.h>
#include "qrcode.h"

TFT_eSPI tftScreen = TFT_eSPI();

/*
  Variables for LNURL
*/
char key[] = "";
String baseUrl = String("https://t1.bleskomat.com/u?");
String id = String("");
// f
String fiatCurrency = String("CZK");
// pd
char defaultDescription[] = "";
String lnurl = String();
String payload;
String signature;
int satoshis = 1;

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
  Serial.println(lnurl);
  showLnurl(lnurl);
}

void create_lnurl() {

  payload = "id=" + id + "&n=" +  esp_random() + "&t=w" + "&f=" + fiatCurrency + "&pn=" + String(bankValue) + "&px=" + String(bankValue) + "&pd=";

  char payloadToSign[payload.length() + 1];

  strcpy(payloadToSign, payload.c_str());

  signature = "";

  sign(payloadToSign, signature);
  Serial.println("signature");
  Serial.println(signature);
  lnurl = baseUrl + payload + "&s=" + signature;
}

void sign(char* payload, String result) {

  byte hmacResult[32];

  mbedtls_md_context_t ctx;
  mbedtls_md_type_t md_type = MBEDTLS_MD_SHA256;

  const size_t payloadLength = strlen(payload);
  const size_t keyLength = strlen(key);

  mbedtls_md_init(&ctx);
  mbedtls_md_setup(&ctx, mbedtls_md_info_from_type(md_type), 1);
  mbedtls_md_hmac_starts(&ctx, (const unsigned char *) key, keyLength);
  mbedtls_md_hmac_update(&ctx, (const unsigned char *) payload, payloadLength);
  mbedtls_md_hmac_finish(&ctx, hmacResult);
  mbedtls_md_free(&ctx);

  for (int i = 0; i < sizeof(hmacResult); i++) {
    char str[3];

    sprintf(str, "%02x", (int)hmacResult[i]);
    signature += String(str);
    Serial.println("signature");
    Serial.println(signature);
  }
}

void showLnurl(String lnurl) {

  tftScreen.fillScreen(TFT_WHITE);
  lnurl.toUpperCase();
  const char* data = lnurl.c_str();

  int qrSize = 12;
  int sizes[17] = { 14, 26, 42, 62, 84, 106, 122, 152, 180, 213, 251, 287, 331, 362, 412, 480, 504 };
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
        tftScreen.drawRect(15 + 3 + scale * x, 3 + scale * y, scale, scale, TFT_BLACK);
      }
      else {
        tftScreen.drawRect(15 + 3 + scale * x, 3 + scale * y, scale, scale, TFT_WHITE);
      }
    }
  }
}
