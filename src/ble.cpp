#include "ble.h"

BLECharacteristic *pCharacteristic;
bool deviceConnected = false;
std::string receivedMessage;

class BleskomatServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer *pServer) {
    deviceConnected = true;
  }

  void onDisconnect(BLEServer *pServer) {
    deviceConnected = false;
  }
};

class BleskomatCharacteristicCallbacks : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *pCharacteristic) {
    std::string value = pCharacteristic->getValue();
    if (value.length() > 0) {
      receivedMessage = value;
      logger::write("Received message in Ble characteristic: ");
      logger::write(receivedMessage.c_str());
      jsonRpc::onBleMessage(receivedMessage.c_str());
    }
  }
};

namespace {
    #define SERVICE_UUID        "8771ff1c-4074-4bc0-9468-d9357cd7026b"
    #define CHARACTERISTIC_UUID "af889f94-5be4-438c-a977-499c55f07a7b"

}

namespace bluetooth {
    void init() {
        BLEDevice::init("Bleskomat Bills");
        logger::write("BLE initialized");
        logger::write(SERVICE_UUID);
        logger::write(CHARACTERISTIC_UUID);
        BLEServer *pServer = BLEDevice::createServer();
        pServer->setCallbacks(new BleskomatServerCallbacks());
        BLEService *pService = pServer->createService(SERVICE_UUID);
        pCharacteristic = pService->createCharacteristic(
            CHARACTERISTIC_UUID,
            BLECharacteristic::PROPERTY_READ |
            BLECharacteristic::PROPERTY_WRITE |
            BLECharacteristic::PROPERTY_NOTIFY |
            BLECharacteristic::PROPERTY_INDICATE
        );
        pCharacteristic->addDescriptor(new BLE2902());
        pCharacteristic->setCallbacks(new BleskomatCharacteristicCallbacks());
        pService->start();
        BLEAdvertising *pAdvertising = pServer->getAdvertising();
        pAdvertising->start();
        logger::write("BLE server started");
    }

    bool isConnected() {
        return deviceConnected;
    }

    void loop() {
        // Do nothing.
    }
}