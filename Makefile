## Usage
#
#   $ make install     # run install process(es)
#   $ make compile     # compile the device firmware
#   $ make upload      # compile then upload the device firmware
#   $ make monitor     # start the serial monitor
#

## Variables
HOST ?= www.bleskomat.com
PORT ?= 443
DEVICE ?= /dev/ttyUSB0
BAUDRATE ?= 115200
SCRIPTS=./scripts
PLATFORM=espressif32

## Targets
#
# The format goes:
#
#   target: list of dependencies
#     commands to build target
#
# If something isn't re-compiling double-check the changed file is in the
# target's dependencies list.

## Phony targets - these are for when the target-side of a definition
# (such as "install" below) isn't a file but instead a just label. Declaring
# it as phony ensures that it always run, even if a file by the same name
# exists.
.PHONY: install\
compile\
upload\
monitor\
fetchCACert

.SILENT: fetchCACert

install:
	platformio lib install
	platformio platform install ${PLATFORM}

compile:
	platformio run

upload:
	platformio run --upload-port ${DEVICE} --target upload

monitor:
	sudo chown ${USER}:${USER} ${DEVICE}
	platformio device monitor --baud ${BAUDRATE} --port ${DEVICE}

fetchCACert:
	echo "" | \
		openssl s_client -showcerts -connect ${HOST}:${PORT} | \
		sed -n "1,/Root/d; /BEGIN/,/END/p" | \
		openssl x509 -outform PEM
