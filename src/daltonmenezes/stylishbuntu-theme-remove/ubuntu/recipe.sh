#!/bin/bash
user_os=`cat /etc/os-release | grep -oP '(?<=^ID=)(.*)'`

function flatabulousThemeRemove {
  sudo apt-get remove flatabulous-theme -y
}

function elGeneralIconsRemove {
  sudo rm -rf /usr/share/icons/ElGeneral
}

function unityConfig {
  gsettings set org.gnome.desktop.interface gtk-theme 'Ambiance'
  gsettings set org.gnome.desktop.interface icon-theme 'ubuntu-mono-dark'
  gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/warty-final-ubuntu.png"
  gsettings set com.canonical.Unity.Launcher launcher-position Left
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode "0"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ edge-responsiveness "5"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size "48"
}

function stylishBuntuThemeRemove {
  flatabulousThemeRemove
  elGeneralIconsRemove
  unityConfig
}


if [[ "$user_os" == "ubuntu" ]]; then
    stylishBuntuThemeRemove
    sudo apt-get autoremove -y
else
    printf "\n\n${STYLE_RED}\nSorry, this theme only works in ${RESET_STYLE}Ubuntu 16.04 with Unity.\n\n"
    exit 0
fi