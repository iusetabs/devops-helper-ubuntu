FROM ubuntu:20.04

# Update the base image
RUN apt-get upgrade --assume-yes
RUN apt-get update --assume-yes
RUN apt-get --assume-yes install curl \
    vim \
    gpg \
    unzip \
    wget 

WORKDIR /home/ubuntu

# Add in helper scripts
COPY installation-scripts installation-scripts
COPY installAll.sh .

# Install all dependencies 
RUN chmod +x ./installation-scripts/*.sh
RUN chmod +x ./installAll.sh
RUN ./installAll.sh

EXPOSE 8080
ENTRYPOINT ["code-server"]





