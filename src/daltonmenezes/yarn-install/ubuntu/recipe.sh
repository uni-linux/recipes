#!/bin/bash
has_curl=$(which curl)

function curlInstall {
  sudo apt-install curl -y
}

function yarnInstall {
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn -y
  clear
}

if [[ $has_curl ]]; then
    yarnInstall
else
   curlInstall
   yarnInstall
fi

has_yarn=$(which yarn)

if [[ $has_yarn ]]; then
   yarn_version=`yarn -v`
   printf "Yarn ${yarn_version} was installed with success! :D\n"   
else
   printf "Sorry, the Yarn installation is failed. Please, try again. :(\n"
fi