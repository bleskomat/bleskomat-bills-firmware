#!/bin/bash

fontSize=$2
inputFontFilePath=$(realpath "$1")
fontName="$(basename "${inputFontFilePath}" | cut -f 1 -d '.' | tr -s ' ' | tr ' ' '_' | tr '-' '_')${fontSize}pt7b"
thisDir=$(realpath $(dirname "$0"))
fontconvert=$(realpath "${thisDir}/../.pio/libdeps/bleskomat32/Adafruit GFX Library/fontconvert/fontconvert")
outDir=$(realpath "${thisDir}/../include/fonts")
outFilePath="${outDir}/${fontName}.h"
headerGuard="BLESKOMAT_FONTS_$(echo -n "${fontName}" | tr '[:lower:]' '[:upper:]')_H"
mkdir -p $outDir
headerFileBytes="$("${fontconvert}" ${inputFontFilePath} ${fontSize})"
headerFileBytes=${headerFileBytes/const uint8_t/const char}

cat > "$outFilePath" <<EOF
#ifndef ${headerGuard}
#define ${headerGuard}

#include <GxEPD2_GFX.h>
#include <pgmspace.h>

${headerFileBytes}

#endif
EOF
