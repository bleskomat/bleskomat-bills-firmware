# bleskomat-device

The Lightning Network ATM with simple components and a simple setup - just plug it in and it works!

* [Overview](#overview)
* [Requirements](#requirements)
* [Setup](#setup)


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
		* [Sublime Text 3](https://www.sublimetext.com/3) + [Deviot (Arduino IDE)](https://packagecontrol.io/packages/Deviot%20(Arduino%20IDE))
	* [M5Stack](https://github.com/m5stack/M5Stack) - Arduino library for the ESP32 used for this project
	* [TFT_eSPI.zip](https://github.com/samotari/bleskomat/tree/master/atm/libraries/TFT_eSPI.zip) - Additional library needed for the TFT screen


## Setup

Install the [Arduino IDE](https://www.arduino.cc/en/Main/Software).

Clone the repository of [M5Stack](https://github.com/m5stack/M5Stack) into your `~/Arduino/libraries` folder.

Download and unzip [TFT_eSPI.zip](https://github.com/samotari/bleskomat/tree/master/atm/libraries/TFT_eSPI.zip) into your `~/Arduino/libraries` folder.

In Arduino IDE, go to `File -> Preferences` and add `https://dl.espressif.com/dl/package_esp32_index.json` to the input field in `Additional Boards Manager URLs`.

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
