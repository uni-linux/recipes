#!/bin/bash
has_curl=$(which curl)

function curlInstall {
  sudo apt-get install curl -y
}

function getLatestLTSVersion {
  lts_version=$(curl -sL https://nodejs.org/en/ | grep -Po '(data-version="v(\d+))' | grep -Po '(\d+)' | head -1)
}

function nodeInstall {
  curl -sL "https://deb.nodesource.com/setup_${lts_version:=12}.x" | sudo -E bash -
  sudo apt-get install -y nodejs
  clear
}

if [[ ! $has_curl ]]; then
    curlInstall
fi

getLatestLTSVersion
nodeInstall

has_node=$(which node)

if [[ $has_node ]]; then
   node_version=`node -v`
   npm_version=`npm -v`
   printf "Node ${node_version} and NPM ${npm_version} were installed with success! :D\n"   
else
   printf "Sorry, the Node installation is failed. Please, try again. :(\n"
fi