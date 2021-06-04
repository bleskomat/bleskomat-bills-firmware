#!/bin/bash

# Font build mode, 0: proportional, 1: common height, 2: monospace, 3: multiple of 8
fontBuildMode=$2
fontSize=$3
inputFontFilePath=$(realpath "$1")
fontName="$(basename "${inputFontFilePath}" | cut -f 1 -d '.' | tr -s ' ' | tr ' ' '_' | tr '-' '_')_${fontSize}pt"
fontName=$(echo -n "${fontName}" | tr '[:upper:]' '[:lower:]')
FONTNAME=$(echo -n "${fontName}" | tr '[:lower:]' '[:upper:]')
thisDir=$(realpath $(dirname "$0"))
outDir="${thisDir}/../include/fonts/u8g2"
buildDir="${thisDir}/../build/fonts/u8g2"
mkdir -p "${outDir}"
mkdir -p "${buildDir}"
outFilePath=$(realpath "${outDir}/${fontName}.h")
bdfFilePath=$(realpath "${buildDir}/${fontName}.bdf")
otf2bdf -v -n -p ${fontSize} "${inputFontFilePath}" -o "${bdfFilePath}"
bdfconv -f 1 -b ${fontBuildMode} -m '32-382' ${bdfFilePath} -o ${outFilePath} -n "u8g2_${fontName}"
headerFileBytes="$(cat "${outFilePath}")"
headerGuard="BLESKOMAT_FONTS_U8G2_${FONTNAME}_H"

cat > "$outFilePath" <<EOF
#ifndef ${headerGuard}
#define ${headerGuard}

#include <U8g2_for_Adafruit_GFX.h>

${headerFileBytes}

#endif
EOF
