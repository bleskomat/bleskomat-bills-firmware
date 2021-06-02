# bleskomat-firmware

This repository contains the source code and basic documentation about how to compile, upload, and test the Bleskomat ATM's firmware.

* [Requirements](#requirements)
	* [Hardware Requirements](#hardware-requirements)
	* [Software Requirements](#software-requirements)
* [Setup](#setup)
	* [Building the Hardware Device](#building-the-hardware-device)
		* [Wiring the E-Paper Module](#wiring-the-e-paper-module)
		* [Wiring the SD Card SPI Module](#wiring-the-sd-card-spi-module)
		* [Wiring the Bill Acceptor](#wiring-the-bill-acceptor)
		* [Wiring the Coin Acceptor](#wiring-the-coin-acceptor)
	* [Configure and Train Coin Acceptor](#configure-and-train-coin-acceptor)
	* [Installing Libraries and Dependencies](#installing-libraries-and-dependencies)
	* [Compiling and Uploading to Device](#compiling-and-uploading-to-device)
	* [Prepare SD Card](#prepare-sd-card)
* [Reprogramming Bill Acceptor](#reprogramming-bill-acceptor)
	* [VirtualBox Setup](#virtualbox-setup)
		* [Create and Configure VM](#create-and-configure-vm)
		* [Install ITL Driver and Validator Manager](#install-itl-driver-and-validator-manager)
	* [Troubleshooting ITL Validator Manager](#troubleshooting-itl-validator-manager)
	* [Standardization of Device Options](#standardization-of-device-options)
* [Fonts](#fonts)
* [License](#license)


## Requirements

This section includes information about the requirements (software + hardware) that you will need to build the physical Bleskomat ATM.


### Hardware Requirements

The following list includes all the parts needed to build the commercial Bleskomat ATM. The list includes direct links to suppliers of each part.

* [ESP-WROOM-32](https://www.espressif.com/en/products/modules/esp-wroom-32/overview) by espressif
	* [laskarduino.cz](https://www.laskarduino.cz/iot-esp-32s-2-4ghz-dual-mode-wifi-bluetooth-rev-1--cp2102/)
* [WaveShare 4.2 inch E-Paper Module (b/w)](https://www.waveshare.com/wiki/4.2inch_e-Paper_Module):
	* [laskarduino.cz](https://www.laskarduino.cz/waveshare-4-2--400x300-epaper-displej-modul-bw/)
* SD Card SPI Module:
	* [laskarduino.cz](https://www.laskarduino.cz/sd-card-modul-spi/)
* [NV9 Banknote Validator](https://innovative-technology.com/products/products-main/378-nv9-usb-2) from Innovative Technology
	* [COMAX LEISURE CZ,a.s.](https://www.akceptory-bankovek.cz/) (located outside of Prague)
* DG600F Coin Acceptor:
	* [Alibaba.com](https://www.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=DG600F)
	* [Sparkfun.com](https://www.sparkfun.com/products/11636)
* 12V DC power adapter (1.5A < 3A):
	* [2.5A (GME)](https://www.gme.cz/napajeci-zdroj-sitovy-12v-2500ma-5-5-2-1mm-t3-sys1588-3012-t3)
* XL4005 Step-down converter:
	* [laskarduino.cz](https://www.laskarduino.cz/step-down-menic-s-xl4005/)
	* [Alibaba.com](https://www.alibaba.com//trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=xl4005)
* Button (stainless steel, without LED):
	* [12 mm (GME)](https://www.gme.cz/antivandal-spinac-hbgq12f-10-n)
	* [16 mm (GME)](https://www.gme.cz/antivandal-spinac-hbgq16b-10-s)
	* [22 mm (GME)](https://www.gme.cz/antivandal-spinac-hbgq22-11-s)


### Software Requirements

* [make](https://www.gnu.org/software/make/) - used as a meta task runner
* [PlatformIO Core (CLI)](https://docs.platformio.org/en/latest/core/)


## Setup

Step-by-step setup process including both hardware and software.


### Building the Hardware Device

Before proceeding, be sure that you have all the project's [hardware requirements](#hardware-requirements).

These are old instructions for connecting all the separate electronic components.


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

|  ESP32       | NV10/NV9 | Power Supply  |
|--------------|----------|---------------|
| GPIO3  (RX0) | 1        |               |
| GPIO17 (TX2) | 5        |               |
|              | 16       | - Ground      |
|              | 15       | + 12V DC      |


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

Use make to install libraries and dependencies for the device firmware:
```bash
make install
```
* The firmware's dependencies are defined in its platformio.ini file located at `./platformio.ini`

If while developing you need to install a new library for the device firmware, use the following as a guide:
```bash
platformio lib install LIBRARY_NAME[@VERSION]
```
You can find PlatformIO's libraries repository [here](https://platformio.org/lib).


### Compiling and Uploading to Device

To compile the firmware (without uploading to a device):
```bash
make compile
```

To compile and upload to your device:
```bash
make upload DEVICE=/dev/ttyUSB0
```
The device path for your operating system might be different. If you receive a "Permission denied" error about `/dev/ttyUSB0` then you will need to set permissions for that file on your system:
```bash
sudo chown $USER:$USER /dev/ttyUSB0
```

To open the serial monitor:
```bash
make monitor DEVICE=/dev/ttyUSB0
```
Again the device path here could be different for your operating system.


## Prepare SD Card

Before continuing here, see [Wiring the SD card](#wiring-the-sd-card).

Format the SD card with FAT32.

The following is an example `bleskomat.conf` file that you could use to configure a bleskomat device. Create the file and copy it to the root directory of the SD card.
```
apiKey.id=6d830ddeb0
apiKey.key=b11cd6b002916691ccf3097eee3b49e51759225704dde88ecfced76ad95324c9
apiKey.encoding=hex
callbackUrl=https://ln.bleskomat.com/u
shorten=true
fiatCurrency=CZK
fiatPrecision=0
buyLimit=20000
coinValues=1,2,5,10,20,50
billValues=100,200,500,1000,2000,5000
webUrl=https://www.bleskomat.com
platformSockUri=wss://www.bleskomat.com/device
platformCACert=-----BEGIN CERTIFICATE-----\nMIIEZTCCA02gAwIBAgIQQAF1BIMUpMghjISpDBbN3zANBgkqhkiG9w0BAQsFADA/\nMSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT\nDkRTVCBSb290IENBIFgzMB4XDTIwMTAwNzE5MjE0MFoXDTIxMDkyOTE5MjE0MFow\nMjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxCzAJBgNVBAMT\nAlIzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuwIVKMz2oJTTDxLs\njVWSw/iC8ZmmekKIp10mqrUrucVMsa+Oa/l1yKPXD0eUFFU1V4yeqKI5GfWCPEKp\nTm71O8Mu243AsFzzWTjn7c9p8FoLG77AlCQlh/o3cbMT5xys4Zvv2+Q7RVJFlqnB\nU840yFLuta7tj95gcOKlVKu2bQ6XpUA0ayvTvGbrZjR8+muLj1cpmfgwF126cm/7\ngcWt0oZYPRfH5wm78Sv3htzB2nFd1EbjzK0lwYi8YGd1ZrPxGPeiXOZT/zqItkel\n/xMY6pgJdz+dU/nPAeX1pnAXFK9jpP+Zs5Od3FOnBv5IhR2haa4ldbsTzFID9e1R\noYvbFQIDAQABo4IBaDCCAWQwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8E\nBAMCAYYwSwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vYXBwcy5p\nZGVudHJ1c3QuY29tL3Jvb3RzL2RzdHJvb3RjYXgzLnA3YzAfBgNVHSMEGDAWgBTE\np7Gkeyxx+tvhS5B1/8QVYIWJEDBUBgNVHSAETTBLMAgGBmeBDAECATA/BgsrBgEE\nAYLfEwEBATAwMC4GCCsGAQUFBwIBFiJodHRwOi8vY3BzLnJvb3QteDEubGV0c2Vu\nY3J5cHQub3JnMDwGA1UdHwQ1MDMwMaAvoC2GK2h0dHA6Ly9jcmwuaWRlbnRydXN0\nLmNvbS9EU1RST09UQ0FYM0NSTC5jcmwwHQYDVR0OBBYEFBQusxe3WFbLrlAJQOYf\nr52LFMLGMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjANBgkqhkiG9w0B\nAQsFAAOCAQEA2UzgyfWEiDcx27sT4rP8i2tiEmxYt0l+PAK3qB8oYevO4C5z70kH\nejWEHx2taPDY/laBL21/WKZuNTYQHHPD5b1tXgHXbnL7KqC401dk5VvCadTQsvd8\nS8MXjohyc9z9/G2948kLjmE6Flh9dDYrVYA9x2O+hEPGOaEOa1eePynBgPayvUfL\nqjBstzLhWVQLGAkXXmNs+5ZnPBxzDJOLxhF2JIbeQAcH5H0tZrUlo5ZYyOqA7s9p\nO5b85o3AM/OJ+CktFBQtfvBhcJVd9wvlwPsk+uyOy2HI7mNxKKgsBTt375teA2Tw\nUdHkhVNcsAKX1H7GNNLOEADksd86wuoXvg==\n-----END CERTIFICATE-----
pingSockUri=wss://ping.bleskomat.com/
pingCACert=-----BEGIN CERTIFICATE-----\nMIIFFjCCAv6gAwIBAgIRAJErCErPDBinU/bWLiWnX1owDQYJKoZIhvcNAQELBQAw\nTzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh\ncmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMjAwOTA0MDAwMDAw\nWhcNMjUwOTE1MTYwMDAwWjAyMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNTGV0J3Mg\nRW5jcnlwdDELMAkGA1UEAxMCUjMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK\nAoIBAQC7AhUozPaglNMPEuyNVZLD+ILxmaZ6QoinXSaqtSu5xUyxr45r+XXIo9cP\nR5QUVTVXjJ6oojkZ9YI8QqlObvU7wy7bjcCwXPNZOOftz2nwWgsbvsCUJCWH+jdx\nsxPnHKzhm+/b5DtFUkWWqcFTzjTIUu61ru2P3mBw4qVUq7ZtDpelQDRrK9O8Zutm\nNHz6a4uPVymZ+DAXXbpyb/uBxa3Shlg9F8fnCbvxK/eG3MHacV3URuPMrSXBiLxg\nZ3Vms/EY96Jc5lP/Ooi2R6X/ExjqmAl3P51T+c8B5fWmcBcUr2Ok/5mzk53cU6cG\n/kiFHaFpriV1uxPMUgP17VGhi9sVAgMBAAGjggEIMIIBBDAOBgNVHQ8BAf8EBAMC\nAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMBMBIGA1UdEwEB/wQIMAYB\nAf8CAQAwHQYDVR0OBBYEFBQusxe3WFbLrlAJQOYfr52LFMLGMB8GA1UdIwQYMBaA\nFHm0WeZ7tuXkAXOACIjIGlj26ZtuMDIGCCsGAQUFBwEBBCYwJDAiBggrBgEFBQcw\nAoYWaHR0cDovL3gxLmkubGVuY3Iub3JnLzAnBgNVHR8EIDAeMBygGqAYhhZodHRw\nOi8veDEuYy5sZW5jci5vcmcvMCIGA1UdIAQbMBkwCAYGZ4EMAQIBMA0GCysGAQQB\ngt8TAQEBMA0GCSqGSIb3DQEBCwUAA4ICAQCFyk5HPqP3hUSFvNVneLKYY611TR6W\nPTNlclQtgaDqw+34IL9fzLdwALduO/ZelN7kIJ+m74uyA+eitRY8kc607TkC53wl\nikfmZW4/RvTZ8M6UK+5UzhK8jCdLuMGYL6KvzXGRSgi3yLgjewQtCPkIVz6D2QQz\nCkcheAmCJ8MqyJu5zlzyZMjAvnnAT45tRAxekrsu94sQ4egdRCnbWSDtY7kh+BIm\nlJNXoB1lBMEKIq4QDUOXoRgffuDghje1WrG9ML+Hbisq/yFOGwXD9RiX8F6sw6W4\navAuvDszue5L3sz85K+EC4Y/wFVDNvZo4TYXao6Z0f+lQKc0t8DQYzk1OXVu8rp2\nyJMC6alLbBfODALZvYH7n7do1AZls4I9d1P4jnkDrQoxB3UqQ9hVl3LEKQ73xF1O\nyK5GhDDX8oVfGKF5u+decIsH4YaTw7mP3GFxJSqv3+0lUFJoi5Lc5da149p90Ids\nhCExroL1+7mryIkXPeFM5TgO9r0rvZaBFOvV2z0gp35Z0+L4WPlbuEjN/lxPFin+\nHlUjr8gRsI3qfJOQFy/9rKIJR0Y/8Omwt/8oTWgy1mdeHmmjk7j1nYsvC9JSQ6Zv\nMldlTTKB3zhThV1+XWYp6rjd5JW1zbVWEkLNxE7GJThEUG3szgBVGP7pSWTUTsqX\nnLRbwHOoq7hHwg==\n-----END CERTIFICATE-----
```


### Configuration Options

The following is a list of all possible configuration options that can be set via the bleskomat.conf configuration file:
* `apiKey.id` - The API key ID of the device. This is needed by the server to verify signatures created by the device.
* `apiKey.key` - The API key secret that is used to generate signatures.
* `apiKey.encoding` - The explicit encoding of the API key secret. This can be "hex", "base64", or empty-string (e.g "") to mean no encoding. When generating a new API key on the server, it will store the encoding along with the ID and secret.
* `callbackUrl` - The LNURL server base URL plus endpoint path. In the case of the official server the value is `https://ln.bleskomat.com/u`. Used as the base URL for signed LNURLs generated by the device.
* `shorten` - Whether or not to shorten the LNURL; see the [lnurl-node module](https://github.com/chill117/lnurl-node#signed-lnurls) for more details.
* `uriSchemaPrefix` - The URI schema prefix for LNURLs generated by the device. It has been discovered that some wallet apps mistakenly only support lowercase URI schema prefixes. Uppercase is better because when encoded as a QR code, the generated image is less complex and so easier to scan. Set this config to empty-string (e.g `uriSchemaPrefix=`) to not prepend any URI schema prefix.
* `fiatCurrency` - The fiat currency symbol for which the device is configured; see [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217).
* `fiatPrecision` - The number of digits to the right of the decimal point when rendering fiat currency amounts.
* `buyLimit` - The per transaction limit (in fiat value) that will be accepted by the device. When an inserted bill would cause the accumulated value to exceed the transaction limit, the bill will be rejected. All coins will be rejected once the largest coin value would cause the limit to be exceeded.
* `coinValues` - The value of coins for which the coin acceptor has been configured. Each value separated by a comma. Integers and floating point (decimal) values are accepted. Examples:
	* CZK: `1,2,5,10,20,50`
	* EUR: `0.05,0.10,0.20,0.50,1,2`
* `billValues` - Same as coin values (above), but for the bill acceptor. Examples:
	* CZK: `100,200,500,1000,2000,5000`
	* EUR: `5,10,20,50,100,200,500`
* `webUrl` - The base URL for the web platform. If non-empty, it will be the base URL for:
	* `/intro?id=API_KEY_ID` - URL shown as a QR code on the instructions screen.
* `platformSockUri` - If the device is connected to WiFi and this value is non-empty, a WebSocket connection will be created to the provided URI. Example values:
	* `wss://www.bleskomat.com/device` -  Uses TLS encryption, must provide the domain's TLS certificate via `platformCACert`
	* `ws://www.bleskomat.com/device` - Unencrypted WebSocket
* `platformCACert` - The PEM-encoded TLS certificate for the Bleskomat Platform. This is required to create a secure WebSocket connection. Fetch and print a certificate with the following command:
	* `make fetchCACert HOST=www.bleskomat.com PORT=443`
* `pingSockUri` - If the device is connected to WiFi and this value is non-empty, a WebSocket connection will be created to the provided URI. Example values:
	* `wss://ping.bleskomat.com/` -  Uses TLS encryption, must provide the domain's TLS certificate via `pingCACert`
	* `ws://ping.bleskomat.com/` - Unencrypted WebSocket
* `pingCACert` - The PEM-encoded TLS certificate for the Bleskomat Platform. This is required to create a secure WebSocket connection. Fetch and print a certificate with the following command:
	* `make fetchCACert HOST=ping.bleskomat.com PORT=443`


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

To download the software and currency sets, you will need to login to an account. Create a new account if you don't already have one. Once you're logged in, [download the software](https://www.innovative-technology.com/index.php/support/secure-download/software-download-secure) from the vendor. You will need to download each of the following:
* "ITL Drivers"
* "Validator Manager"

You can download currency sets from the vendor's website [here](https://www.innovative-technology.com/index.php/support/secure-download/currency-download-secure). Be sure to select the "NV9 Range". The dataset files are zip archives that typically contain more than one dataset file. These datasets have ".bv1" file extension and appear to be a proprietary binary data format. See "11.10 File Naming Convention" in the NV9 user manual for details about the naming conventions used for these dataset files.

Before you can connect to the NV9 via the IF17 programming kit, you will need to set the NV9 to SSP mode ("programming mode"). You can check the NV9's current mode by pressing the red button on the side two times quickly ("double-click"). The red light on the front will flash a certain number of times indicating its current mode. One flash means that it is already set to SSP mode. To set the NV9 to SSP mode, hold down the red button for more than 3 seconds. See section "11.5 Switching to Programming Mode (SSP)" in the NV9 user manual for more details.

The rest of the instructions depend upon your system.

* [VirtualBox Setup](#virtualbox-setup)
	* [Create and Configure VM](#create-and-configure-vm)
	* [Install ITL Driver and Validator Manager](#install-itl-driver-and-validator-manager)
* [Troubleshooting ITL Validator Manager](#troubleshooting-itl-validator-manager)


### VirtualBox Setup

The instructions provided here are what worked for me (chill - using Ubuntu). If you get stuck on a step, see the "SOFTWARE INSTALLATION AND CONFIGURATION" section of the NV9 Manual for further details.

* [Installation instructions for VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)
* [Download a virtual machine from Microsoft](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/) - be sure to use Windows 7 or Windows 8. Once the download is complete, extract the zip archive - it should contain a single file with .ova extension.


#### Create and Configure VM

Run VirtualBox. Go to "File" -> "Import Appliance" and select the .ova Windows VM file. Click next to start the import. Once completed, you should see a new virtual machine in your VirtualBox.

The default amount of __video memory__ allocated to the VM is below the minimum requirement. So you will need to increase it to 32 MB (or more). Right-click the virtual machine and choose "Settings". Select "Display" from the menu on the left. Change the video memory here and then save it.

Change the __graphics controller__ to "VBoxSVGA". This setting is located in the same screen as video memory.

Download and install the VirtualBox Extension Pack. It can be found in your VirtualBox's version folder [here](https://download.virtualbox.org/virtualbox). Check your VirtualBox version from the "Help" -> "About VirtualBox" menu.

Download VirtualBox Guest Additions. It can be found in your VirtualBox's version folder [here](https://download.virtualbox.org/virtualbox). It is an .iso image file that you will mount as an optical disk in the Windows virtual machine.

Start the virtual machine. The guest OS will capture your mouse cursor. To release the cursor back to the host OS, press the right CTRL key. Open the VirtualBox Guest Additions disk. Run the 64bit exe file. Follow the installation instructions. After complete, restart the VM. Shutdown the virtual machine.

Disconnect the NV9's 16-pin serial connector. Connect the IF17 USB cable to your computer. Reconnect the NV9's serial connector. Open a terminal window and run the following:
```bash
sudo modprobe -r ftdi_sio ; \
	sudo modprobe ftdi_sio vendor=0x0403 product=0x6001
```
For more information about what this is doing, see "2.3 Linux installation" in the Innovative Technology Customer Software Guide.

Enable the __USB controller__. Select "USB 3.0". Add a new USB filter and select "FTDI USB <-> Serial [0400]" from the list.

__IMPORTANT NOTE__:
If your VirtualBox is not able to detect the "FTDI USB <-> Serial [0400]" device, you can try to configure a serial port instead:
* Find the "Serial Ports" in the virtual machine's settings
* Select "Port 1" and then click "Enable Serial Port"
* Port Number should be set to "COM1"
* Port Mode set to "Host Device"
* Path/Address set to "/dev/ttyUSB0"
* Change the owner of the device file to your user: `sudo chown $USER /dev/ttyUSB0`

Add a __shared folder__ to the virtual machine. We will use this folder to provide required files to the virtual machine (like device drivers). Mark the shared folder as "read-only".

After booting for the second time, the shared folder should be accessible in the File Explorer.


#### Install ITL Driver and Validator Manager

Copy the software and datasets that you downloaded from the vendor to the shared folder. Unzip the zip archives as needed.

On the Windows VM, open the shared folder. Find "ITL Drivers / IF17 / IF17 Driver Installer.exe". Copy this executable to the desktop.

Before running the executable, you will need to reboot Windows into a special boot mode that will allow you to install unsigned drivers. Below are the installation instructions included with the ITL Driver software. Open Command Prompt as administrator to run the shutdown command.
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


### Troubleshooting ITL Validator Manager

In this section we will document common problems (and solutions!) that you might encounter while reprogramming the NV9.

> No devices were found

* Is the USB from the IF17 connected to your computer?
* Is the NV9 in SSP mode? Press the red button two times fast (double-click). The light on the bevel will flash once when the device is set to SSP mode. See section "11.5 Switching to Programming Mode (SSP)" in the NV9 user manual for more details.
* While USB is connected to your computer, disconnect the 16-pin serial connector from the NV9 then reconnect it. Wait for the NV9 to finish its start-up, then try to "Detect devices" again in the ITL Validator Manager.
* Try disconnecting/reconnecting both the USB from your computer and the 16-pin serial connector on the device.

> Not supported by device/model

* Check the ".bv1" file name. These dataset files have specific naming conventions to help you recognize which file will work with your device. See [Interpreting Dataset File Names](https://innovative-technology.com/support/faq-2/item/148-interpreting-dataset-file-names) on the vendor's website.

> Update unsuccessful, please check your files are correct.

* Change the baud rate to 38400 and try the upload again.
* Note that you may need to disconnect/reconnect the 16-pin serial connector from the device before you can connect to it again with the ITL Validator Manager.

> No Key Set

This error can happen while attempting to change the device's options from the "Options" tab. Click the "Reload Options" button. Wait for the options to reload from the device. Make the changes you want. Then try "Apply Changes" again.


### Standardization of Device Options

This section describes how to set the options for your NV9.

* Run the ITL Validator Manager program and "Detect Device".
* Once connected, open the "Options" tab.
* Click "Reload Options" to get the device's current configuration.

Make sure the following options are set to the correct values:

| Option                  | Value                   |
|-------------------------|-------------------------|
| Interface               | SIO (Simple Serial)     |

Set the interface-related options as follows:

| SIO Options             | Value         |
|-------------------------|---------------|
| Credit card rejection   | Off           |
| Disable After Escrow    | Off           |
| Escrow Timeout          | On            |
| High Speed Baud         | On            |
| Internal bezel          | On            |
| PSU Monitor             | Off           |
| Serial Output Only      | Off           |
| Stacker Retry Time      | 1             |
| Start State             | On            |


## License

This project is "unlicensed" meaning all copyrights are withheld. This is the closed-source, extended version of the device for the commercial Bleskomat ATMs.

There is an [open-source version](https://github.com/samotari/bleskomat) of this project that hackers and hobbyist are welcome to use as a guide to build their own Bleskomat ATMs.
