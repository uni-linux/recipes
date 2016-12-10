#!/bin/bash
user_os=`cat /etc/os-release | grep -oP '(?<=^ID=)(.*)'`

function albertSpotlightConfig {
  mkdir -p $HOME/.config/albert/
  touch $HOME/.config/albert/albert.conf | printf "[General]\nalwaysOnTop=true\ndisplayIcons=true\ndisplayScrollbar=false\ndisplayShadow=true\nhideOnClose=false\nhideOnFocusLoss=true\nhotkey=Shift+Space\nitemCount=5\nshowCentered=true\nshowTray=false\ntheme=Bright\nwarnAboutNonGraciousQuit=false" > $HOME/.config/albert/albert.conf
  mkdir -p $HOME/.config/autostart/
  touch $HOME/.config/autostart/albert.desktop
  albertDesktopEntry="[Desktop Entry]\nType=Application\nExec=albert\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[pt_BR]=albert\nName=albert"
  printf "$albertDesktopEntry" > $HOME/.config/autostart/albert.desktop
}

function albertSpotlightInstall {
  if [[ ! -f "/usr/bin/albert" ]]; then
      sudo apt-get install albert -y
      albertSpotlightConfig
      albert &>/dev/null &
  else
      pkill -9 albert
      albertSpotlightConfig
      albert &>/dev/null &
  fi
}

function macbuntuConfig {
  gsettings set org.gnome.desktop.interface gtk-theme 'MacBuntu-OS'
  gsettings set org.gnome.desktop.interface icon-theme 'MacBuntu-OS'
  gsettings set org.gnome.desktop.interface cursor-theme 'DMZ-Black'
}

function macbuntuInstall {
  if [[ ! -d "/usr/share/themes/MacBuntu-OS-X" ]]; then
      sudo add-apt-repository ppa:noobslab/macbuntu -y
      sudo apt-get update
      sudo apt-get install macbuntu-os-icons-lts-v7 -y
      sudo apt-get install macbuntu-os-ithemes-lts-v7 -y
      macbuntuConfig
  else
      macbuntuConfig
  fi
}

function wallpaperConfig {
  gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/mac-os-sierra-uni-theme.jpg"
}

function wallpaperInstall {
  if [[ ! -f "/usr/share/backgrounds/mac-os-sierra-uni-theme.jpg" ]]; then
    wget 'https://github.com/uni-linux/recipes/raw/master/src/daltonmenezes/mac-theme/bin/mac-os-sierra.jpg' -O .mac-os-sierra-uni-theme.jpg
    sudo mv -fu .mac-os-sierra-uni-theme.jpg /usr/share/backgrounds/mac-os-sierra-uni-theme.jpg
    wallpaperConfig
  else
      wallpaperConfig
  fi
}

function plankThemeConfig {
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme "Gnosierra"
}

function plankThemeInstall {
  if [[ ! -d "$HOME/.local/share/plank/themes/Gnosierra/" ]]; then
      wget 'https://github.com/uni-linux/recipes/raw/master/src/daltonmenezes/mac-theme/bin/gnosierra.zip' -O .gnosierra.zip
      unzip .gnosierra.zip -d $HOME/.local/share/plank/themes/
      plankThemeConfig
  else
      plankThemeConfig
  fi
}

function plankConfig {
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-size "50"
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
      touch $HOME/.config/plank/dock1/launchers/trash.dockitem | printf "[PlankDockItemPreferences]\nLauncher=docklet://trash" > $HOME/.config/plank/dock1/launchers/trash.dockitem
      plankConfig
      plankThemeInstall
      plankThemeConfig
      plank &>/dev/null &
  else
      pkill -9 plank
      plankConfig
      plankThemeConfig
      plank &>/dev/null &
  fi
}

function unityConfig {
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ edge-responsiveness "0.20000000000000001110"
  gsettings set com.canonical.Unity.Launcher launcher-position Bottom
  gsettings set com.canonical.Unity always-show-menus true
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode "0"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode "1"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size "10"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ num-launchers "1"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ panel-opacity "0.82857142857142851433"
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ panel-opacity-maximized-toggle "true"
  setsid unity
}

function ubuntuInstall {
  albertSpotlightInstall
  macbuntuInstall
  unityConfig
  plankInstall
  wallpaperInstall
}

if [[ "$user_os" == "ubuntu" ]]; then
    ubuntuInstall
else
    printf "\n\n${STYLE_RED}\nSorry, for now this theme only works in ${RESET_STYLE}Ubuntu with Unity.\n\n"
    exit 0
fi
