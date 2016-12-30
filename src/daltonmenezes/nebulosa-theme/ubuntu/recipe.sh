#!/bin/bash
user_os=`cat /etc/os-release | grep -oP '(?<=^ID=)(.*)'`
os_version=`cat /etc/os-release | grep -oP '(?<=^VERSION_ID=").*(?=\")'`

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
  gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/nebulosa-uni-theme.jpg"
}

function wallpaperInstall {
  if [[ ! -f "/usr/share/backgrounds/nebulosa-uni-theme.jpg" ]]; then
      wget 'https://github.com/uni-linux/recipes/raw/master/src/daltonmenezes/nebulosa-theme/bin/nebulosa-ghost.jpg' -O .nebulosa-uni-theme.jpg
      sudo mv -fu .nebulosa-uni-theme.jpg /usr/share/backgrounds/nebulosa-uni-theme.jpg
      wallpaperConfig
  else
      wallpaperConfig
  fi
}

function plankConfig {
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-size "50"
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme "Transparent"
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ zoom-enabled "true"
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ zoom-percent "150"
}

function plankInstall {
  if [[ ! -f "/usr/bin/plank" ]]; then
      sudo apt-get install plank -y
      mkdir -p $HOME/.config/autostart/
      touch $HOME/.config/autostart/plank.desktop
      desktopEntry="[Desktop Entry]\nType=Application\nExec=plank\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[pt_BR]=plank\nName=plank"
      printf "$desktopEntry" > $HOME/.config/autostart/plank.desktop
      mkdir -p $HOME/.config/plank/dock1/launchers/
      touch $HOME/.config/plank/dock1/launchers/trash.dockitem | printf "[PlankDockItemPreferences]\nLauncher=docklet://trash" > $HOME/.config/plank/dock1/launchers/trash.dockitem
      plankConfig
      plank &>/dev/null &
  else
      pkill -9 plank
      plankConfig
      plank &>/dev/null &
  fi
}

function unityConfig {
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ edge-responsiveness "0.20000000000000001110"
  gsettings set com.canonical.Unity.Launcher launcher-position Bottom
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode "0"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode "1"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size "10"
}

function ubuntuInstall {
  elGeneralInstall
  flatabulousInstall
  wallpaperInstall
  plankInstall
  unityConfig
}

function ubuntuBasedDistrosInstall {
  elGeneralInstall
  wallpaperInstall
}

if [[ "$user_os" == "ubuntu" && $os_version < "16.04" ]]; then
    sudo add-apt-repository ppa:ricotz/docky -y
    sudo apt-get update
fi

if [[ "$user_os" == "ubuntu" ]]; then
    ubuntuInstall
else
    ubuntuBasedDistrosInstall
fi
