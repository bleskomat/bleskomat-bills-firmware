#include <SPI.h>

const byte coinSig = 4;
bool previousCoinSignal = false;

unsigned long previousUpdateMillis = 0;
unsigned long updateInterval = 110;

bool printOnceFlag;

const float coinValue = 1.00;
float bankValue = 0.00;

void setup() {
  Serial.begin(115200);
  pinMode(coinSig, INPUT_PULLUP);


  Serial.println(0);
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
}
