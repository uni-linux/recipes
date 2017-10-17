#!/bin/bash
has_telegram=$(which telegram)
has_Telegram=$(which Telegram)

if [[ ! -z $has_telegram ]]; then
    telegram="telegram"
else
    telegram="Telegram"
fi

if [[ ! -z $has_telegram ||  ! -z $has_Telegram ]]; then
    sudo rm -rf /opt/$telegram/
    sudo rm -f /usr/bin/$telegram
    sudo rm -f /usr/share/applications/$telegram.desktop
    sudo rm -f /home/$USER/.local/share/applications/telegramdesktop.desktop
    sudo rm -f /home/$USER/.local/share/icons/telegram.png
    printf "Telegram was removed with success! :D\n"
else
    echo "Telegram doesn't seems to exist in your PC. So, there's nothing to remove here.\n"
    exit 0
fi
