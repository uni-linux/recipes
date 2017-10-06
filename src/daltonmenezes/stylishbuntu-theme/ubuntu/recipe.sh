#!/bin/bash
user_os=`cat /etc/os-release | grep -oP '(?<=^ID=)(.*)'`

function elGeneralConfig {
  gsettings set org.gnome.desktop.interface icon-theme 'ElGeneral'
}

function elGeneralInstall {
  if [[ ! -d "/usr/share/icons/ElGeneral" ]]; then
      wget 'https://github.com/uni-linux/recipes/raw/master/src/daltonmenezes/nebulosa-theme/bin/El-General-Gnome117.tar.gz' -O .el-general.tar.gz
      tar -xzf .el-general.tar.gz
      sudo rm -rf /usr/share/icons/ElGeneral
      sudo mv El-General-Gnome/ElGeneral /usr/share/icons/
      rm -f .el-general.tar.gz
      rm -rf El-General-Gnome
      elGeneralConfig
  else
      elGeneralConfig
  fi
}

function flatabulousConfig {
  gsettings set org.gnome.desktop.interface gtk-theme 'Flatabulous'
}

function flatabulousInstall {
  if [[ ! -d "/usr/share/themes/Flatabulous" ]]; then
      sudo add-apt-repository ppa:noobslab/themes -y
      sudo apt-get update
      sudo apt-get install flatabulous-theme -y
      flatabulousConfig
  else
      flatabulousConfig
  fi
}

function wallpaperConfig {
  gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/warty-final-ubuntu.png"
}


function unityConfig {
  gsettings set com.canonical.Unity.Launcher launcher-position Left
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode "0"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ edge-responsiveness "5"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size "48"  
}

function ubuntuInstall {
  elGeneralInstall
  flatabulousInstall
  wallpaperConfig
  unityConfig
}

if [[ "$user_os" == "ubuntu" ]]; then
    ubuntuInstall
else
    printf "\n\n${STYLE_RED}\nSorry, for now this theme only works in ${RESET_STYLE}Ubuntu 16.04 with Unity.\n\n"
    exit 0
fi