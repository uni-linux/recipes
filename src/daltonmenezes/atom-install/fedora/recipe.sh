#!/bin/bash
wget https://atom.io/download/rpm -O atom.rpm
sudo dnf install -y atom.rpm
rm -f atom.rpm
