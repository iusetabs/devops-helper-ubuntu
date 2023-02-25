#!/bin/bash

# Installs terraform

echo "Installing terraform"

architecture="$(dpkg --print-architecture)"
apt-get --assume-yes install unzip


if [ "$architecture" == "arm64" ]  || [ "$architecture" == "amd64" ];
then
    wget https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_"$architecture".zip
    unzip terraform_1.3.9_linux_"$architecture"
    mv terraform /usr/local/bin/
    terraform --version
fi