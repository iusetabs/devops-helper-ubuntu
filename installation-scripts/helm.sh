#!/bin/bash

# Installs helm using apt 
# Generally up to date - checked on 24/02/23 and apt could provide latest helm binary

echo "Installing helm"

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
apt-get --assume-yes install apt-transport-https 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get --assume-yes update 
apt-get --assume-yes install helm
helm version