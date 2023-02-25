#!/bin/bash

# Installs the code server

echo "Installing code server"

architecture="$(dpkg --print-architecture)"
VERSION="4.10.0"

wget https://github.com/coder/code-server/releases/download/v$VERSION/code-server_"$VERSION"_"$architecture".deb
dpkg -i code-server_"$VERSION"_"$architecture".deb
# Now visit http://127.0.0.1:8080. Your password is in ~/.config/code-server/config.yaml