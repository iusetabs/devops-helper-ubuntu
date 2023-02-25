#!/bin/bash

# Installs EKS ctl 

echo "Installing EKS ctl"

architecture="$(dpkg --print-architecture)"

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_$architecture.tar.gz" | tar xz -C /tmp

mv /tmp/eksctl /usr/local/bin

eksctl version