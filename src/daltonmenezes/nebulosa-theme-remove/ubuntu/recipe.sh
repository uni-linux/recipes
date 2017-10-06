#!/bin/bash
user_os=`cat /etc/os-release | grep -oP '(?<=^ID=)(.*)'`

function elGeneralIconsRemove {
  sudo rm -rf /usr/share/icons/ElGeneral
}

function wallpaperRemove {
  sudo rm -rf /usr/share/backgrounds/nebulosa-uni-theme.jpg
}

function flatabulousThemeRemove {
  sudo apt-get remove flatabulous-theme -y
}

function plankRemove {
  pkill -9 plank
  sudo apt-get purge plank -y
  rm -f $HOME/.config/autostart/plank.desktop
  rm -rf $HOME/.config/plank/
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

function ubuntuNebulosaThemeRemove {
  flatabulousThemeRemove
  plankRemove
  elGeneralIconsRemove
  wallpaperRemove  
  unityConfig
}

function ubuntuBasedDistrosNebulosaThemeRemove {
  elGeneralIconsRemove
  wallpaperRemove    
}

if [[ "$user_os" == "ubuntu" ]]; then
    ubuntuNebulosaThemeRemove
    sudo apt-get autoremove -y
else
    ubuntuBasedDistrosNebulosaThemeRemove
    sudo apt-get autoremove -y
fi