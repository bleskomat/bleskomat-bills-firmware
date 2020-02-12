# Bleskomat V2


## Getting started

In order to get started with development you need:

* [Arduino IDE](https://www.arduino.cc/en/Main/Software)

Once you have installed [Arduino IDE](https://www.arduino.cc/en/Main/Software), you will have an `~/Arduino/libraries` folder in you user directory that you can use to include libraries:

* Clone the repository of [M5Stack](https://github.com/m5stack/M5Stack) into your `~/Adurino/libraries` folder.
* Add uncompressed `TFT_eSPI.zip` from this repository `/libraries` folder to your `~/Arduino/libraries` folder.
* In you arduino IDE go to `File -> Preferences` and `https://dl.espressif.com/dl/package_esp32_index.json` to the input field in `Additional Boards Manager URLs`.


## Cables mapping

### TFT screen

|  ESP32  | TFT          |
|---------|--------------|
| VIN     | VCC          |
| GND     | GND          |
| CS      | GPIO5  (D5)  |
| Reset   | GPIO16 (RX2) |
| AO (DC) | GPIO17 (TX2) |
| SDA     | GPIO23 (D23) |
| SCK     | GPIO18 (D18) |
| LED     | 3.3V (3V3)   |
