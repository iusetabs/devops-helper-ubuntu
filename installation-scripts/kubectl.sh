#!/bin/bash
# Installs kubectl - must be ran with sudo persmissions
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management

# Update the apt package index and install packages needed to use the Kubernetes apt repository:

echo "Installing kubectl"

apt-get update
apt-get install -assume apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key:

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add the Kubernetes apt repository:

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

# Update apt package index with the new repository and install kubectl:

apt-get update --assume-yes
apt-get install -y kubectl

kubectl version

# Install bash-completion 
apt-get install bash-completion -y
echo source /usr/share/bash-completion/bash_completion >> ~/.bashrc

# Enable kubectl autocompletion
echo 'source <(kubectl completion bash)' >> ~/.bashrc

# Set up kubectl alias
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc


