#!/bin/bash
wget https://atom.io/download/deb -O atom.deb
sudo dpkg -i atom.deb
rm -f atom.deb
sudo apt-get -f install -y
