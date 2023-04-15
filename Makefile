## Usage
#
#   $ make install     # run install process(es)
#   $ make compile     # compile the device firmware
#   $ make upload      # compile then upload the device firmware
#   $ make monitor     # start the serial monitor
#

## Variables
BAUDRATE ?= 115200
DEVICE ?= /dev/ttyUSB0
FONTS=./assets/fonts
PLATFORM=espressif32
SCRIPTS=./scripts

## Phony targets - these are for when the target-side of a definition
# (such as "install" below) isn't a file but instead a just label. Declaring
# it as phony ensures that it always run, even if a file by the same name
# exists.
.PHONY: install\
compile\
upload\
monitor\
.git-commit-hash

install:
	pio pkg install --platform ${PLATFORM}

compile: .git-commit-hash
	pio run

upload: .git-commit-hash
	sudo chown ${USER}:${USER} ${DEVICE}
	pio run --upload-port ${DEVICE} --target upload

monitor:
	sudo chown ${USER}:${USER} ${DEVICE}
	pio device monitor --baud ${BAUDRATE} --port ${DEVICE}

.git-commit-hash:
	-git rev-parse HEAD 2>/dev/null && git rev-parse HEAD > .git-commit-hash

fonts: bdfconv
	$(SCRIPTS)/generate-font-header-files.sh "$(FONTS)/CheckbookLightning/CheckbookLightning.ttf" 1 32-122 16,20,24,28,32,36,40,44,48
	$(SCRIPTS)/generate-font-header-files.sh "$(FONTS)/Courier Prime Code/Courier Prime Code.ttf" 2 32-382 8,10,12,16,20,24,28,32,36,40,44,48
	$(SCRIPTS)/generate-font-header-files.sh "$(FONTS)/OpenSans/Light/OpenSans-Light.ttf" 1 32-382 8,10,12,14,16,18

bdfconv: ./tools/bdfconv/bdfconv

./tools/bdfconv/bdfconv:
	cd ./tools/bdfconv && make bdfconv
