#!/bin/bash
has_curl=$(which curl)
has_node=$(which node)

function curlInstall {
  sudo apt-get install curl -y
}

function nodeInstall {
  uni bake daltonmenezes/node-install
}

function yarnInstall {
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn -y
  clear
}

if [[ ! -z $has_curl ]]; then
    curlInstall
fi

if [[ ! -z $has_node ]]; then
    nodeInstall
fi

yarnInstall

has_yarn=$(which yarn)

if [[ $has_yarn ]]; then
   yarn_version=`yarn -v`
   printf "Yarn ${yarn_version} was installed with success! :D\n"   
else
   printf "Sorry, the Yarn installation is failed. Please, try again. :(\n"
fi