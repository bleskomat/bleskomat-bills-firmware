# bleskomat-device

The Lightning Network ATM with simple components and a simple setup - just plug it in and it works!

* [Overview](#overview)
* [Requirements](#requirements)
* [Setup](#setup)
	* [Prepare Arduino IDE](#setup-with-arduino-ide)
	* [Prepare With SublimeText3](#setup-with-sublimetext3)
* [License](#license)


## Overview

Key features include:
* Works offline - no WiFi required
* Inexpensive, easily-sourced components
* Easily hackable and extendible

The project consists of two parts:
* __Physical Device (ATM)__ - user inserts coins, device generates a signed URL and displays as QR code, user's app (which supports lnurl-withdraw) scans QR code and makes request to HTTP server, withdraw process is completed and the user has successfully bought satoshis with fiat coins.
* __HTTP Server__ - supports [lnurl-withdraw](https://github.com/btcontract/lnurl-rfc/blob/master/lnurl-withdraw.md) with additional request handlers for fiat-currency -> satoshi conversion and request signing.

This repository contains the source and build instructions for the physical device. The source code and documentation for the HTTP server component is located in a [separate repository](https://github.com/samotari/bleskomat-server).


## Requirements

This section includes information about the requirements (software + hardware) that you will need to build the physical Bleskomat ATM. 

To build the physical device:
* Hardware:
	* ESP32
	* TFT screen
	* Coin Acceptor
	* 12V DC power adaptor
* Software:
	* [Arduino IDE](https://www.arduino.cc/en/Main/Software); alternative:
		* [Sublime Text 3](https://www.sublimetext.com/3) + [Deviot (Arduino IDE)](https://packagecontrol.io/packages/Deviot%20(Arduino%20IDE)) + [PlatformIO](https://docs.platformio.org/)
	* [M5Stack](https://github.com/m5stack/M5Stack) - Arduino library for the ESP32 used for this project
	* [TFT_eSPI.zip](https://github.com/samotari/bleskomat/tree/master/atm/libraries/TFT_eSPI.zip) - Additional library needed for the TFT screen


## Setup

The setup process begins with preparing an IDE that includes tools to compile, debug, and deploy C/C++ code to your ESP32 device. Choose your IDE and continue.

### Prepare Arduino IDE

Install the [Arduino IDE](https://www.arduino.cc/en/Main/Software).

Clone the repository of [M5Stack](https://github.com/m5stack/M5Stack) into your `~/Arduino/libraries` folder.

Download and unzip [TFT_eSPI.zip](https://github.com/samotari/bleskomat/tree/master/atm/libraries/TFT_eSPI.zip) into your `~/Arduino/libraries` folder.

In Arduino IDE, go to `File -> Preferences` and add `https://dl.espressif.com/dl/package_esp32_index.json` to the input field in `Additional Boards Manager URLs`.


### Prepare SublimeText3

This guide assumes you already have SublimeText3 installed.

Install PlatformIO by following these [installation instructions](https://docs.platformio.org/en/latest/core/installation.html#installation-methods).

Now you can install the [Deviot (Arduino IDE)](https://packagecontrol.io/packages/Deviot%20(Arduino%20IDE)) package for SublimeText3. Recommended installation method is to use the built-in Package Control of SublimeText: `Preferences` -> `Package Control` -> `Install Package` -> Type `"Deviot"` -> Click `"Deviot (Arduino IDE)"`.

Clone the repository of [M5Stack](https://github.com/m5stack/M5Stack) into your `~/.platformio/lib/` folder.

Download and unzip [TFT_eSPI.zip](https://github.com/samotari/bleskomat/tree/master/atm/libraries/TFT_eSPI.zip) into your `~/.platformio/lib/` folder.

Install QRCode library: `Deviot` -> `Find/Install Library` -> Type `"QRCode"` -> Find and click `"QRCode"` from the list of libraries.

Open the `./bleskomat/bleskomat.ino` file in SublimeText. Right-click anywhere in the file and then click `Compile` in the context menu. It will prompt you to select a board. Type `"esp32 expressif"` and then select the only board remaining: `"Espressif ESP32 Dev Module"`.

If everything worked, you should see something like this in the terminal at the bottom:
```
========================= [SUCCESS] Took 1.97 seconds =========================

[Wed May  6 19:49:55 2020]
```


### Cable map to connect ESP32 to TFT screen

|  ESP32       | TFT      |
|--------------|----------|
| VIN          | VCC      |
| GND          | GND      |
| GPIO5  (D5)  | CS       |
| GPIO16 (RX2) | RS       |
| GPIO17 (TX2) | AO (DC)  |
| GPIO23 (D23) | SDA      |
| GPIO18 (D18) | SCK      |
| 3.3V (3V3)   | LED (NC) |


## License

This project is "unlicensed" meaning all copyrights are withheld. This is the closed-source, extended version of the device for the commercial Bleskomat ATMs.

There is an [open-source version](https://github.com/samotari/bleskomat) of this project that hackers and hobbyist are welcome to use as a guide to build their own Bleskomat ATMs.
