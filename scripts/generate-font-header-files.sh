#!/bin/bash

thisDir=$(realpath $(dirname "$0"))
outDir="${thisDir}/../include/fonts/u8g2"
buildDir="${thisDir}/../build/fonts/u8g2"

mkdir -p ${outDir}
mkdir -p ${buildDir}

bdfconv="${thisDir}/../tools/bdfconv/bdfconv"
echo "bdfconv = ${bdfconv}"
if [ ! -f "$bdfconv" ]; then
	echo "bdfconv tool not found"
	exit 1
fi

fontFilePath=$(realpath "$1")
if [ ! -f "$fontFilePath" ]; then
	echo "Font file does not exist"
	exit 1
fi

buildMode="$2"
if [[ ! $buildMode =~ ^[0123]$ ]]; then
	echo "Build mode can be: 0 = proportional, 1 = common height, 2 = monospace, or 3 = multiple of 8"
	exit 1
fi

charRange="$3"
if [[ ! $charRange =~ ^[0-9]+-[0-9]+$ ]]; then
	echo "Character range must contain numbers and hyphen only. Example: ${0} ./path/to/font.ttf 32-127 10,12,14"
	exit 1
fi

fontSizes="$4"
if [[ $fontSizes =~ [^0-9,] ]]; then
	echo "Font sizes must contain numbers and commas only. Example: ${0} ./path/to/font.ttf 32-127 10,12,14"
	exit 1
fi
# Set the delimiter then split string into an array:
IFS=','
read -ra fontSizesArray <<< "$fontSizes"

for fontSize in "${fontSizesArray[@]}"; do
	fontName="$(basename "${fontFilePath}" | cut -f 1 -d '.' | tr -s ' ' | tr ' ' '_' | tr '-' '_')_${fontSize}pt"
	fontNameLower=$(echo -n "${fontName}" | tr '[:upper:]' '[:lower:]')
	fontNameUpper=$(echo -n "${fontName}" | tr '[:lower:]' '[:upper:]')
	outFilePath=$(realpath "${outDir}/${fontNameLower}.h")
	if [ ! -f ${outFilePath} ]; then
		bdfFilePath=$(realpath "${buildDir}/${fontNameLower}.bdf")
		if [ ! -f ${bdfFilePath} ]; then
			otf2bdf -v -n -p ${fontSize} "${fontFilePath}" -o "${bdfFilePath}"
		fi
		${bdfconv} -f 1 -b ${buildMode} -m ${charRange} ${bdfFilePath} -o ${outFilePath} -n "u8g2_${fontNameLower}"
		headerFileBytes="$(cat ${outFilePath})"
		headerGuard="BLESKOMAT_FONTS_U8G2_${fontNameUpper}_H"
cat > "$outFilePath" <<EOF
#ifndef ${headerGuard}
#define ${headerGuard}

#include <U8g2_for_Adafruit_GFX.h>

${headerFileBytes}

#endif
EOF
		echo "Created ${outFilePath}"
	fi
done
