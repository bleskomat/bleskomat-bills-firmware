#include <SPI.h>
#include "mbedtls/md.h"
#include <string>

/*
	Varialbes for LNURL
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
	Varialbes for Coin Acceptor 616
*/
const byte coinSig = 4;
bool previousCoinSignal = false;
unsigned long previousUpdateMillis = 0;
unsigned long updateInterval = 110;
bool printOnceFlag;
const float coinValue = 1.00;
float bankValue = 0.00;

void setup() {
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
