#!/bin/bash
has_curl=$(which curl)

function curlInstall {
  sudo apt-get install curl -y
}

function nodeInstall {
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
  sudo apt-get install -y nodejs
  clear
}

if [[ ! $has_curl ]]; then
    curlInstall
fi

nodeInstall

has_node=$(which node)

if [[ $has_node ]]; then
   node_version=`node -v`
   npm_version=`npm -v`
   printf "Node ${node_version} and NPM ${npm_version} were installed with success! :D\n"   
else
   printf "Sorry, the Node installation is failed. Please, try again. :(\n"
fi