#!/bin/bash

# Intalls helm file

echo "Installing helm file"

architecture="$(dpkg --print-architecture)"
apt-get install --assume-yes tar gzip zip unzip bzip2

wget https://github.com/helmfile/helmfile/releases/download/v0.151.0/helmfile_0.151.0_linux_"$architecture".tar.gz
mkdir -p helmfile-temp
tar -xvf helmfile_0.151.0_linux_"$architecture".tar.gz -C helmfile-temp
mv helmfile-temp/helmfile /usr/local/bin
rm -rf helmfile-temp

helmfile --version
