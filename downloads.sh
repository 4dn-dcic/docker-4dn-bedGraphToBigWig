#!/bin/sh

## SOFTWARE: bedGraphToBigWig
## VERSION: v302.1.0
## TYPE: file format converter
## SOURCE_URL: https://github.com/ENCODE-DCC/kentUtils
git clone https://github.com/ENCODE-DCC/kentUtils
cd kentUtils/
git checkout v302.1.0
make
cd ..
