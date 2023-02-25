#!/bin/bash

# Installs the AWS IAM Authenticator

echo "Beginning AWS IAM Authenticator installation"

version="0.5.9"

architecture="$(dpkg --print-architecture)"

curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v"$version"/aws-iam-authenticator_"$version"_linux_"$architecture"

curl -Lo aws-iam-authenticator.txt https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v"$version"/authenticator_"$version"_checksums.txt

#checksumFromRemote="$(awk '/aws-iam-authenticator_"$version"_linux_"$architecture"/ {print $1}' aws-iam-authenticator.txt)"
#checksumFromLocal="$(openssl sha1 -sha256 aws-iam-authenticator)"

#if [[ "$checksumFromRemote" != "$checksumFromLocal" ]]  
#then 
    #printf "Error: Checksum failed." >&2
    #exit 1
#fi

chmod +x ./aws-iam-authenticator

mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator

echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

mv aws-iam-authenticator /usr/local/bin/

aws-iam-authenticator version