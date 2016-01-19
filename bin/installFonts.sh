#!/bin/bash
# execute as root (via sudo)
fontdir="$(dirname $0)/../lib/fonts"
mkdir -p /usr/share/fonts/opentype/Fandol
mkdir -p /usr/share/fonts/truetype/cwTeX
cp "${fontdir}/FandolFang-Regular.otf" /usr/share/fonts/opentype/Fandol/
cp "${fontdir}/cwTeXQKai-Medium.ttf" /usr/share/fonts/truetype/cwTeX/
exec fc-cache
