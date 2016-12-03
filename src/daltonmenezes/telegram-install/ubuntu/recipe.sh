#!/bin/bash
has_telegram=$(which telegram)
has_Telegram=$(which Telegram)
arch=$(uname -m)

if [ $arch == "x86_64" ]; then
    download_for="linux"
else
    download_for="linux32"
fi

function install {
  wget https://telegram.org/dl/desktop/$download_for -O telegram.tar.xz
  sudo tar Jxf telegram.tar.xz -C /opt/
  sudo mv /opt/Telegram*/ /opt/telegram
  sudo ln -sf /opt/telegram/Updater /usr/bin/telegram
  rm -f telegram.tar.xz
  /opt/telegram/Telegram &
}

if [[ ! -z $has_telegram ]]; then
    telegram="telegram"
else
    telegram="Telegram"
fi

if [[ ! -z $has_telegram ||  ! -z $has_Telegram ]]; then
    sudo rm -rf /opt/$telegram/
    sudo rm -f /usr/bin/$telegram
    sudo rm -f /usr/share/applications/$telegram.desktop
    install
else
    install
fi
