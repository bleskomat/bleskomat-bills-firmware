# bleskomat-device

The Lightning Network ATM with simple components and a simple setup - just plug it in and it works!

* [Overview](#overview)
* [Requirements](#requirements)
	* [Hardware Requirements](#hardware-requirements)
		* [Parts Suppliers](#parts-suppliers)
	* [Software Requirements](#software-requirements)
* [Setup](#setup)
	* [Building the Hardware Device](#building-the-hardware-device)
		* [Wiring Diagram](#wiring-diagram)
		* [Wiring the Power Supply](#wiring-the-power-supply)
		* [Wiring the E-Paper Module](#wiring-the-e-paper-module)
		* [Wiring the SD Card SPI Module](#wiring-the-sd-card-spi-module)
		* [Wiring the Bill Acceptor](#wiring-the-bill-acceptor)
		* [Wiring the Coin Acceptor](#wiring-the-coin-acceptor)
	* [Configure and Train Coin Acceptor](#configure-and-train-coin-acceptor)
	* [Installing Libraries and Dependencies](#installing-libraries-and-dependencies)
	* [Generating Your Local Config File](#generating-your-local-config-file)
	* [Compiling and Uploading to Device](#compiling-and-uploading-to-device)
	* [Prepare SD Card](#prepare-sd-card)
* [Reprogramming Bill Acceptor](#reprogramming-bill-acceptor)
	* [Using VirtualBox](#using-virtualbox)
* [Fonts](#fonts)
* [License](#license)


## Overview

Key features include:
* Works offline - no WiFi required
* Inexpensive, easily-sourced components
* Easily hackable and extendible

The project consists of two parts:
* __Physical Device (ATM)__ - user inserts bills or coins, device generates a signed URL and displays as QR code, user's app (which supports lnurl-withdraw) scans QR code and makes request to HTTP server, withdraw process is completed and the user has successfully bought satoshis with fiat money.
* __HTTP Server__ - supports [lnurl-withdraw](https://github.com/btcontract/lnurl-rfc/blob/master/lnurl-withdraw.md) with additional request handlers for fiat-currency -> satoshi conversion and request signing.

This repository contains the source and build instructions for the physical device. The source code and documentation for the HTTP server component is located in a [separate repository](https://github.com/samotari/bleskomat-server).


## Requirements

This section includes information about the requirements (software + hardware) that you will need to build the physical Bleskomat ATM.


### Hardware Requirements

To build the physical device, you will need the following hardware components:
* [ESP-WROOM-32](https://www.espressif.com/en/products/modules/esp-wroom-32/overview) by espressif
	* [laskarduino.cz](https://www.laskarduino.cz/iot-esp-32s-2-4ghz-dual-mode-wifi-bluetooth-rev-1--cp2102/)
* [WaveShare 4.2 inch E-Paper Module (b/w)](https://www.waveshare.com/wiki/4.2inch_e-Paper_Module):
	* [laskarduino.cz](https://www.laskarduino.cz/waveshare-4-2--400x300-epaper-displej-modul-bw/)
* SD Card SPI Module:
	* [laskarduino.cz](https://www.laskarduino.cz/sd-card-modul-spi/)
* Bill Acceptor - [NV10](https://innovative-technology.com/products/products-main/127-nv10-usb)
* Coin Acceptor - "Model HX-616"
* 12V DC power adapter (1.5A < 3A):
	* [GME](https://www.gme.cz/napajeci-zdroj-sitovy-12v-2500ma-5-5-2-1mm-t3-sys1588-3012-t3)
* USB (female) adapter:
	* [laskarduino.cz](https://www.laskarduino.cz/usb-f-na-dip-adapter/)
* Step-down converter:
	* [laskarduino.cz](https://www.laskarduino.cz/step-down-menic-s-xl4005/)
* Relay module:
	* [laskarduino.cz](https://www.laskarduino.cz/1-kanal-5v-rele-modul--low-level--250vac-10a/)
* Button:
	* [GME](https://www.gme.cz/) has many available


#### Parts Suppliers

* [GM Electronic](https://www.gme.cz/):
	* physical shop
	* tools and electronics parts
	* usually missing most components and not the most helpful staff
* [laskarduino](https://www.laskarduino.cz/):
	* eshop only
	* hobby electronics projects
	* cheap and good selection
* [arduino-shop](https://arduino-shop.cz/):
	* eshop only
	* expensive and limited selection
* [COMAX LEISURE CZ,a.s.](https://www.akceptory-bankovek.cz/)
	* NV10 and other bank note acceptors
	* physical shop
	* Modletice 71, 251 70 MODLETICE
	* info@comax.cz
	* Main contact:  "Martin Zych" - martin.zych@comax.cz



### Software Requirements

* [PlatformIO Core (CLI)](https://docs.platformio.org/en/latest/core/)
* [nodejs](https://nodejs.org/) - For Linux and Mac install node via [nvm](https://github.com/creationix/nvm)


## Setup

Step-by-step setup process including both hardware and software.


### Building the Hardware Device

Before proceeding, be sure that you have all the project's [hardware requirements](#hardware-requirements).


#### Wiring Diagram

Here is a wiring diagram for the Bleskomat ATM:

![](docs/wiring-diagram.png)


#### Wiring the Power Supply

The first step to building the device is wiring the power supply. If already plugged in, __unplug__ the 12V DC power supply now. Use scissors to cut the end off the power supply so that you can freely access the two wires within, as shown in the following image:

![](docs/12v-dc-power-supply.jpg)

It is important to test the wires to know for certain which is the ground. Use a [multimeter](https://duckduckgo.com/?q=multimeter&t=canonical&iar=images&iax=images&ia=images) to measure the voltage of the power supply:
* Plug-in the power supply to electricity
* Turn on your multimeter and set it to measure voltage in the appropriate range
* Touch the __red__ lead of your multimeter to one of the wires
* Touch the __black__ lead of your multimeter to the other wire
* If you see a negative voltage reading, swap the leads between the two wires
* The wire touched by the __black__ lead is the ground ("GND")
* The wire touched by the __red__ lead is the hot wire ("PWR")
* Unplug the power supply again

Now use the [wiring diagram](#wiring-diagram) above as a guide to wire the ESP32 to the power supply.

Note that powering the ESP32 via its micro USB port requires a regulated voltage of approximately 5V. The suggested step-down converter is the [XL4005](https://www.laskarduino.cz/step-down-menic-s-xl4005/). It does a good job of keeping a steady voltage and doesn't generate much heat.

Once you've connected the step-down converter to the power supply, use your multimeter to measure the voltage at the out pins. Use a small screwdriver to turn the screw on the little blue box. Turning the screw counter clockwise should lower the voltage, turning it the opposite direction should increase the voltage. Once you have the voltage set to 5V, you can connect the USB (F) adapter to the out pins.

Use a standard USB to micro USB cable to connect the ESP32.

Do not forget to connect the ESP32 to the common ground. Without this connection, the ESP32 will not be able to receive pulses from the coin acceptor when the ESP32 is connected to your computer via USB.

There are other options when powering the ESP32 - e.g via the 3.3V pin or the 5V/VIN pin. You should __never__ power the ESP32 via more than one of these options at the same time. For example, do not power the ESP32 via its 3.3V pin while also connecting the ESP32 via USB to your computer. This can damage the ESP32 and possibly also your computer.




#### Wiring the E-Paper Module

Connect the E-Paper display module to the ESP32 using the following table as a guide:

| ESP32 | E-Paper Display Module |
|-------|------------------------|
| D25   | BUSY                   |
| D26   | RST                    |
| D27   | DC                     |
| D15   | CS                     |
| D13   | CLK                    |
| D14   | DIN                    |
| GND   | GND                    |
| 3.3V  | VCC                    |


#### Wiring the SD Card SPI Module

Connect the SD card SPI module to the ESP32 using the following table as a guide:

| ESP32 | SD Card SPI Module |
|-------|--------------------|
| GND   | GND                |
| 3.3V  | 3.3                |
|       | 5                  |
| D5    | CS                 |
| D23   | MOSI               |
| D18   | SCK                |
| D19   | MISO               |
| GND   | GND                |


#### Wiring the Bill Acceptor

Have a look at the [wiring diagram](#wiring-diagram) above or the table of cable mappings below:

|  ESP32      | NV10 | Power Supply  |
|-------------|------|---------------|
| GPIO3 (RX0) | 1    |               |
|             | 16   | - Ground      |
|             | 15   | + 12V DC      |


#### Wiring the Coin Acceptor


|  ESP32      | DG600F   | Power Supply  |
|-------------|----------|---------------|
| GPIO21      | INHIBIT  |               |
| GPIO16      | SERIAL   |               |
|             | COUNTER  |               |
|             | GND      | - Ground      |
|             | 12V DC   | + 12V DC      |


### Configure and Train Coin Acceptor

Physical switches on the DG600F should set as follows:

| Switch           | State         |
|------------------|---------------|
| 1 (Port Level)   | Down (NO)     |
| 2 (Security)     | Down (Normal) |
| 3 (Transmitting) | Up (RS232)    |
| 4 (Inhibiting)   | Down (> +3V)  |

![](docs/coin-acceptor-DG600F-dip-setting-switch.png)

Open the [DG600F manual](docs/DG600F-coin-acceptor-manual.pdf) to "Coin Acceptor Parameters Setting" on page 18. Set the parameters as follows:

| Parameter | Description                      | Value | Meaning                                          |
|-----------|----------------------------------|-------|--------------------------------------------------|
| A1        | machine charge amount            | 01    | min. coin value before data sent                 |
| A2        | serial output signal pulse-width | 01    | 25ms / 9600 bps (RS232 baud rate)                |
| A3        | faulty alarm option              | 01    | (rings only one time)                            |
| A4        | serial port RS232 signal length  | 03    | 3 bytes: 0xAA, coin value, XOR of prev two bytes |
| A5        | serial port output               | 01    | output to serial pin                             |


To train the coin acceptor, have a look at "Coin Parameters Setting" on page 16 of the [DG600F manual](docs/DG600F-coin-acceptor-manual.pdf). Be sure to set the "coin value" for each coin in series, incremented by 1. For example:
* 1 CZK = 1 coin value
* 2 CZK = 2 coin value
* 5 CZK = 3 coin value
* 10 CZK = 4 coin value
* 20 CZK = 5 coin value
* 50 CZK = 6 coin value

Then in bleskomat.conf, set the `coinValues` setting as follows:
```
coinValues=1,2,5,10,20,50
```


### Installing Libraries and Dependencies

Before proceeding, be sure that you have all the project's [software requirements](#software-requirements).

First thing to do is to install npm dependencies:
```bash
npm install
```
Node is used as a task runner and to generate new (or read existing) API keys.

Next you will need to install required libraries for the C/C++ builds:
```bash
platformio lib install
```
See the `platformio.ini` file for a list of libraries that will be downloaded and installed.

If while developing you need to install a new library, use the following command as a guide:
```bash
platformio lib install --save LIBRARY_NAME[@VERSION]
```
The `--save` flag tells platformio to add the library to the project's `platformio.ini` file.

You can find PlatformIO's libraries repository [here](https://platformio.org/lib).


### Generating Your Local Config File

A helper script is used to generate the local configuration file that is needed to connect to the server's Postgres database, encrypt/decrypt sensitive data (like API key secrets), and to set other required configuration options for the device build process. Let's get started:
```bash
npm run config -- init
```
This will walk you thru the process of generating the local config file.

You can choose to generate an encrypted or decrypted config file. You should note that the build process will require an unencrypted config file in order to run. It is possible to decrypt the config file as follows:
```bash
npm run config -- decrypt
```
Or to encrypt it:
```bash
npm run config -- encrypt
```


### Compiling and Uploading to Device

To compile the project (without uploading to a device):
```bash
npm run compile:only
```
To run the build with dummy/invalid API-key-related build flags:
```bash
npm run compile:only
```

To compile and upload to your device:
```bash
DEVICE=/dev/ttyUSB0 npm run compile:upload
```
The device path for your operating system might be different. If you receive a "Permission denied" error about `/dev/ttyUSB0` then you will need to set permissions for that file on your system:
```bash
sudo chown $USER:$USER /dev/ttyUSB0
```
To run the build with dummy/invalid API-key-related build flags:
```bash
DEVICE=/dev/ttyUSB0 npm run compile:upload
```

To open the serial monitor:
```bash
DEVICE=/dev/ttyUSB0 npm run monitor
```
Again the device path here could be different for your operating system.


## Prepare SD Card

Before continuing here, see [Wiring the SD card](#wiring-the-sd-card).

Format the SD card with FAT32. Create a configuration file with the following command:
```bash
npm run print:config "6d830ddeb0" > ./bleskomat.conf
```
This will generate a new configuration file named `bleskomat.conf` for the API key ID `"6d830ddeb0"`. The contents of the config file will be something like this:
```
apiKey.id=6d830ddeb0
apiKey.key=b11cd6b002916691ccf3097eee3b49e51759225704dde88ecfced76ad95324c9
apiKey.encoding=hex
callbackUrl=https://0fe4d56b.eu.ngrok.io/lnurl
fiatCurrency=CZK
shorten=true
fiatPrecision=0
buyLimit=20000
coinValues=1,2,5,10,20,50
billValues=100,200,500,1000,2000,5000
instructionsUrl=https://www.bleskomat.com/intro?id={{API_KEY_ID}}
```
Copy this file to the SD card.

You can also print dummy configuration values by omitting the API key ID:
```bash
npm run print:config > ./bleskomat.conf
```

### Configuration Options

The following is a list of all possible configuration options that can be set via the bleskomat.conf configuration file:
* `apiKey.id` - The API key ID of the device. This is needed by the server to verify signatures created by the device.
* `apiKey.key` - The API key secret that is used to generate signatures.
* `apiKey.encoding` - The explicit encoding of the API key secret. This can be "hex", "base64", or empty-string (e.g "") to mean no encoding. When generating a new API key on the server, it will store the encoding along with the ID and secret.
* `callbackUrl` - The LNURL server base URL plus endpoint path. In the case of the official server the value is `https://ln.bleskomat.com/u`. Used as the base URL for signed LNURLs generated by the device.
* `fiatCurrency` - The fiat currency symbol for which the device is configured; see [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217).
* `shorten` - Whether or not to shorten the LNURL; see the [lnurl-node module](https://github.com/chill117/lnurl-node#signed-lnurls) for more details.
* `uriSchemaPrefix` - The URI schema prefix for LNURLs generated by the device. It has been discovered that some wallet apps mistakenly only support lowercase URI schema prefixes. Uppercase is better because when encoded as a QR code, the generated image is less complex and so easier to scan. Set this config to empty-string (e.g `uriSchemaPrefix=`) to not prepend any URI schema prefix.
* `fiatPrecision` - The number of digits to the right of the decimal point when rendering fiat currency amounts.
* `buyLimit` - The per transaction limit (in fiat value) that will be accepted by the device. When an inserted bill would cause the accumulated value to exceed the transaction limit, the bill will be rejected. All coins will be rejected once the largest coin value would cause the limit to be exceeded.
* `coinValues` - The value of coins for which the coin acceptor has been configured. Each value separated by a comma. Integers and floating point (decimal) values are accepted. Examples:
	* CZK: `1,2,5,10,20,50`
	* EUR: `0.05,0.10,0.20,0.50,1,2`
* `billValues` - Same as coin values (above), but for the bill acceptor. Examples:
	* CZK: `100,200,500,1000,2000,5000`
	* EUR: `5,10,20,50,100,200,500`
* `instructionsUrl` - The full URL to the web server's instructions page. For the Bleskomat server this is "https://www.bleskomat.com/intro?id={{API_KEY_ID}}". The `{{API_KEY_ID}}` is replaced with the device's API key ID (URL-encoded). This URL is rendered as a QR code on the device's instructions screen.


## Fonts

Each font used to render text on the E-Paper display is loaded from a C-style header file. If you need to add another font family or size, you will need to:
* [Install fontconvert dependencies](#install-fontconvert-dependencies)
* [Build The Adafruit GFX fontconvert tool from source](#build-the-adafruit-gfx-fontconvert-tool-from-source)
* Download the font(s) you want in `.ttf` format
* [Generate Font Header File](#generate-font-header-file)


### Install fontconvert dependencies

On Ubuntu it's pretty simple:
```bash
sudo add-apt-repository ppa:glasen/freetype2 \
	&& sudo apt-get update \
	&& sudo apt-get install -yq freetype2-demos libfreetype6 libfreetype6-dev
```

### Build The Adafruit GFX fontconvert tool from source

```bash
cd .pio/libdeps/bleskomat32/Adafruit\ GFX\ Library/fontconvert \
	&& make
```
Alternatively, you can find the fontconvert source and build scripts in the [Adafruit GFX Library repository](https://github.com/adafruit/Adafruit-GFX-Library/tree/master/fontconvert).


### Generate Font Header File

On Linux, your installed fonts can be found at `~/.local/share/fonts`. Or you can download fonts from the many font collections online. You will need fonts in `.ttf` format. There are tools that can convert other formats to `.ttf`, but that's outside the scope of this section.

Use the following command to generate a font header file:
```bash
./scripts/generateFontHeaderFile.sh ~/.local/share/fonts/OpenSans/Light/OpenSans-Light.ttf 16
```
This will generate a new header font file at `./include/fonts/OpenSans_Light16pt7b.h`. You will need to include the new font in the `./includes/modules/epaper.h` file as follows:
```cpp
// ...

#include "fonts/OpenSans_Light16pt7b.h"

// ...
```
And then use the font in `./src/modules/epaper.cpp` as follows:
```cpp
const std::string text = "Using a new font";
int16_t x = display.width() / 2;// center
int16_t y = display.height() / 2;//center
TextBoundingBox text_box;
renderText(text, &OpenSans_Light16pt7b, x, y, &text_box);
```


## Reprogramming Bill Acceptor

The NV9 bill acceptor can be reprogrammed by using the proprietary software and hardware provided by the vendor ("Innovative Technology"). You will need the [DA2 Programming Kit](https://innovative-technology.com/shop/accessories/da2-programming-kit-detail) before you can continue here.

To download the software and currency sets, you will need to login to an account. Create a new account if you don't already have one. Once you're logged in, [download the software](https://www.innovative-technology.com/index.php/support/secure-download/software-download-secure) from the vendor. You will need to downloading each of the following:
* "ITL Drivers"
* "Validator Manager"

You can download currency sets from the vendor's website [here](https://www.innovative-technology.com/index.php/support/secure-download/currency-download-secure). Be sure to select the "NV9 Range".

The rest of the instructions depend upon your system.


### Using VirtualBox

The instructions provided here are what worked for me (chill - using Ubuntu). If you get stuck on a step, see the "SOFTWARE INSTALLATION AND CONFIGURATION" section of the NV9 Manual for further details.

* [Installation instructions for VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)
* [Download a virtual machine from Microsoft](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/) - be sure to use Windows 7 or Windows 8. Once the download is complete, extract the zip archive - it should contain a single file with .ova extension.


#### Set the NV9 to Programming Mode

Before you can connect to the NV9 via the IF17 programming kit, you will need to set the NV9 to SSP mode. You can check the NV9's mode first by pressing the red button on the side two times quickly ("double-click"). The red light on the front will flash a certain number of times indicating its current mode. One flash means that it is already set to SSP mode. See section "11.5 Switching to Programming Mode (SSP)" in the NV9 user manual for more details.


#### Create and Configure VM

Run VirtualBox. Go to "File" -> "Import Appliance" and select the .ova Windows VM file. Click next to start the import. Once completed, you should see a new virtual machine in your VirtualBox.

The default amount of __video memory__ allocated to the VM is below the minimum requirement. So you will need to increase it to 32 MB (or more). Right-click the virtual machine and choose "Settings". Select "Display" from the menu on the left. Change the video memory here and then save it.

Change the __graphics controller__ to "VBoxSVGA". This setting is located in the same screen as video memory.

Disconnect the NV9's 16-pin serial connector. Connect the IF17 USB cable to your computer. Reconnect the NV9's serial connector. Open a terminal window and run the following:
```bash
sudo modprobe -r ftdi_sio
sudo modprobe ftdi_sio vendor=0x0403 product=0x6001
```
For more information about what this is doing, see "2.3 Linux installation" in the Innovative Technology Customer Software Guide.

Enable the __USB controller__. Select "USB 1.1". Add new USB filter and select "FTDI USB <-> Serial [0400]".

Add a __shared folder__ to the virtual machine. We will use this folder to provide required files to the virtual machine (like device drivers). Mark the shared folder as "read-only".

Download VirtualBox Guest Additions. You will need to find your VirtualBox's version folder [here](https://download.virtualbox.org/virtualbox). Check your VirtualBox version from the "Help" -> "About VirtualBox" menu. It is an .iso image file that you will mount as a optical disk in the Windows virtual machine.

Start the virtual machine. The guest OS will capture your mouse cursor. To release the cursor back to the host OS, press the right CTRL key. Open the VirtualBox Guest Additions disk. Run the 64bit exe file. Follow the installation instructions. After complete, restart the VM.

After booting for the second time, the shared folder should be accessible in the File Explorer.


#### Install ITL Driver and Validator Manager

On the Windows VM, open the shared folder. Find "ITL Drivers / IF17 / IF17 Driver Installer.exe". Copy this executable to the desktop.

Before running the executable, you will need to reboot Windows into a special boot mode that will allow you to install unsigned drivers. Follow these instructions:
```
Windows 8 requires drivers to be signed by microsoft.  This will prevent installation of ITL 
drivers being installed.

If you have a windows 8 platform, the below instructions will disable this feature, and installation 
can continue.

Basically you have to boot in a non-standard mode.

The easy way to do this is to use the Shutdown command with the  /o  parameter:
So you open a admin level command prompt and type:

shutdown.exe /r /o /f /t 0

    /r         Full shutdown and restart the computer.
    /o         Go to the advanced boot options menu and restart the computer.
               Must be used with /r option.
    /f         Force running applications to close without forewarning users.
    /t xxx     Set the time-out period before shutdown to xxx seconds.

When the system restarts you can select "Disable Driver Signature Enforcement" from the option screens.
```
Now run the copy of "IF17 Driver Installer.exe" on the desktop.

Copy the "ITL Validator Manager(vs4.6).exe" (your version may be newer) to the desktop. Run the executable from the desktop.

Restart Windows.

Run the ITL Validator Manager. Click "Detect Devices". The red part of the IF17 device should start to blink. It will take up to a minute to finish communicating with the NV9.


## License

This project is "unlicensed" meaning all copyrights are withheld. This is the closed-source, extended version of the device for the commercial Bleskomat ATMs.

There is an [open-source version](https://github.com/samotari/bleskomat) of this project that hackers and hobbyist are welcome to use as a guide to build their own Bleskomat ATMs.
