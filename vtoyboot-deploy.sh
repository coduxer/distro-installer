#!/bin/bash

URL="$(curl -s https://api.github.com/repos/ventoy/vtoyboot/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"
FILENAME=`basename $URL`
EXT="${FILENAME##*.}"
if ! [ "$EXT" = "iso" ]; then
    echo "looking for file name with 'iso' extention but got $FILENAME"
    exit -1    
fi
TMP_DIR=`mktemp -d`

wget "$URL" -P "$TMP_DIR"
EXTRACT_DIR="$TMP_DIR/iso-output"
mkdir "$EXTRACT_DIR"

if ! [ -x "$(command -v 7z)" ]; then
    echo '7z is not installed, installing...' 
    sudo apt-get install p7zip-full
fi

7z x "$TMP_DIR/$FILENAME" -o$EXTRACT_DIR
[[ ! `ls $EXTRACT_DIR | wc -l` = '1' ]] && echo "iso have more then 1 file inside need to have only one" 1>&2;rm -rf $EXTRACT_DIR; exit -1
TARFILE=($EXTRACT_DIR/*)
[[ ! "${TARFILE##*.}" = "gz" ]] && (echo "iso have more then 1 file inside need to have only one" 1>&2;rm -rf $EXTRACT_DIR; exit -1)
tar xavf "$TARFILE" -C $EXTRACT_DIR
echo $EXTRACT_DIR
#rm -rf $EXTRACT_DIR

