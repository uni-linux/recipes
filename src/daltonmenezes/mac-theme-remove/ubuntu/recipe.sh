#!/bin/bash
user_os=`cat /etc/os-release | grep -oP '(?<=^ID=)(.*)'`

function albertSpotlightRemove {
  pkill -9 albert
  sudo apt-get purge albert -y
  rm -rf $HOME/.config/albert/
  rm -f $HOME/.config/autostart/albert.desktop
}

function macbuntuRemove {
  sudo apt-get purge macbuntu-os-icons-lts-v7 -y
  sudo apt-get purge macbuntu-os-ithemes-lts-v7 -y
}

function wallpaperRemove {
  sudo rm -f /usr/share/backgrounds/mac-os-sierra-uni-theme.jpg
}

function plankThemeRemove {
  rm -rf $HOME/.local/share/plank/themes/Gnosierra/
}

function plankRemove {
  pkill -9 plank
  sudo apt-get purge plank -y
  rm -f $HOME/.config/autostart/plank.desktop
  rm -rf $HOME/.config/plank/
  plankThemeRemove
}

function unityConfig {
  gsettings set org.gnome.desktop.interface gtk-theme 'Ambiance'
  gsettings set org.gnome.desktop.interface icon-theme 'ubuntu-mono-dark'
  gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/warty-final-ubuntu.png"
  gsettings set com.canonical.Unity.Launcher launcher-position Left
  gsettings set com.canonical.Unity always-show-menus false
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode "0"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ edge-responsiveness "5"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size "48"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ num-launchers "1"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ panel-opacity "1.0"
  setsid unity
}

function ubuntuMacThemeRemove {
  albertSpotlightRemove
  macbuntuRemove
  plankRemove
  wallpaperRemove
  unityConfig
}

if [[ "$user_os" == "ubuntu" ]]; then
    ubuntuMacThemeRemove
    sudo apt-get autoremove -y
else
    printf "\n\n${STYLE_RED}\nSorry, for now this theme only works in ${RESET_STYLE}Ubuntu with Unity.\n\n"
    exit 0
fi
