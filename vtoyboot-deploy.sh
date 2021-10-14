#!/bin/bash
INSTALL_DIR=/opt/vtoyboot
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

7z x "$TMP_DIR/$FILENAME" -o"$EXTRACT_DIR"


[ ! "$(ls $EXTRACT_DIR | wc -l)" = "1" ] && { echo "iso have more then 1 file inside need to have only one" ; rm -rf "$EXTRACT_DIR" ; exit 1; }
TARFILE=($EXTRACT_DIR/*)
[[ ! "${TARFILE##*.}" = "gz" ]] && { echo "iso have more then 1 file inside need to have only one" ;rm -rf $EXTRACT_DIR; exit -1; }
TAR_EXTRACT_DIR="$EXTRACT_DIR/tar"
mkdir $TAR_EXTRACT_DIR
sudo tar xavf "$TARFILE" -C $TAR_EXTRACT_DIR
[ ! "$(ls $TAR_EXTRACT_DIR | wc -l)" = "1" ] && { echo "iso have more then 1 file inside need to have only one" ; rm -rf "$EXTRACT_DIR" ; exit 1; }
echo $EXTRACT_DIR
sudo rm -rf $INSTALL_DIR || 1
sudo mkdir $INSTALL_DIR
sudo mv $TAR_EXTRACT_DIR/*/* $INSTALL_DIR
sudo echo '#!/bin/bash' > /tmp/vtoyboot
sudo echo "( cd $INSTALL_DIR; ./vtoyboot.sh; )" >> /tmp/vtoyboot
sudo cp /tmp/vtoyboot /usr/local/bin/vtoyboot
sudo chmod +x /usr/local/bin/vtoyboot
sudo rm /tmp/vtoyboot
#rm -rf $EXTRACT_DIR
sudo echo '#!/bin/bash' > /tmp/zzz-vtoyboot
sudo echo "/usr/local/bin/vtoyboot" >> /tmp/zzz-vtoyboot
sudo cp /tmp/zzz-vtoyboot /etc/kernel/postinst.d
sudo chmod +x /etc/kernel/postinst.d/zzz-vtoyboot
sudo vtoyboot