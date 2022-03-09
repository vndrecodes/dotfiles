#!/bin/bash

depends_on() {
  $1 -v > /dev/null
  if [ $? -ne 0 ]; then
    echo "Missing dependency"
    echo "Depends on: $1"
    exit 1
  fi
}


# install c-compiler & git
install_xcode() {
  xcode-select -v > /dev/null 2>&1

  if [ $? -ne 0 ]; then
    xcode-select --install
  fi
}


upgrade_nano() {
  cd ~/Downloads
  depends_on "xcode-select"
  curl -O  https://www.nano-editor.org/dist/v6/nano-6.0.tar.gz
  tar xvzf nano-6.0.tar.gz
  cd nano-6.0
  ./configure
  make
  make install

  cd ~
  ALIAS_NANO="alias nano=/usr/local/bin/nano"
  if [ -f ".zshenv"]; then
    echo $ALIAS_NANO >> .zshenv
  else
    echo ".zshenv not found!"
    echo "Add: $ALIAS_NANO manually."
  fi
}


main() {
  install_xcode
  upgrade_nano
}

main
