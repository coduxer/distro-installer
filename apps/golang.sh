VERSION=`curl -s https://raw.githubusercontent.com/archlinux/svntogit-community/packages/go/trunk/PKGBUILD | grep 'pkgver=' | sed 's/pkgver=//'`
TEMP='/tmp/downloads/golang'
mkdir -p "$TEMP"
FILEPATH="$TEMP/go$VERSION.linux-amd64.tar.gz"
if [ ! -f $FILEPATH ]; then
    wget "https://golang.org/dl/go$VERSION.linux-amd64.tar.gz" -P "$TEMP"
fi

sudo rm -rf /usr/local/go 
sudo tar -C /usr/local -xzf "$FILEPATH"

if ! grep -q '/usr/local/go/bin' "$HOME/.profile"; then

    { echo '#set PATH for golang' 
      echo 'if [ -d "/usr/local/go/bin" ] ; then' 
      echo '    PATH="$PATH:/usr/local/go/bin"'
      echo 'fi'; } >> ~/.profile
fi