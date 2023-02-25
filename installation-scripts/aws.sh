#!/bin/bash

# This script verifies and installs the AWS CLI on Ubuntu.
# If the installation already exists then it will not be installed

startTime=$(date +%s)

echo "AWS CLI is not installed. Beginning installation."

architecture="$(dpkg --print-architecture)"
awsArchKey=""

if [[ "$architecture" == "arm"* ]];
then
  awsArchKey="aarch64"
else 
  awsArchKey="x86_64"
fi

curl "https://awscli.amazonaws.com/awscli-exe-linux-$awsArchKey.zip" -o "awscliv2.zip"
curl -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-"$awsArchKey".zip.sig
# To install a specific version, append to the installation file ( before .zip ) the desired version e.g. "-2.0.30"


echo "Starting integrity check"
# Enable if not already installed locally ( e.g. a docker image which already has these installed )
# apt install gpg --assume-yes
# apt install unzip --assume-yes

# New lines are necessary otherwise GPG complains
echo "-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBF2Cr7UBEADJZHcgusOJl7ENSyumXh85z0TRV0xJorM2B/JL0kHOyigQluUGZMLhENaG0bYatdrKP+3H91lvK050pXwnO/R7fB/FSTouki4ciIx5OuLlnJZIxSzxPqGl0mkxImLNbGWoi6Lto0LYxqHN2iQtzlwTVmq9733zd3XfcXrZ3+LblHAgEt5GTfNxEKJ8soPLyWmwDH6HWCnjZ/aIQRBTIQ05uVeEoYxSh6wOai7ss/KveoSNBbYzgbdzoqI2Y8cgH2nbfgp3DSasaLZEdCSsIsK1u05CinE7k2qZ7KgKAUIcT/cR/grkC6VwsnDU0OUCideXcQ8WeHutqvgZH1JgKDbznoIzeQHJD238GEu+eKhRHcz8/jeG94zkcgJOz3KbZGYMiTh277Fvj9zzvZsbMBCedV1BTg3TqgvdX4bdkhf5cH+7NtWOlrFj6UwAsGukBTAOxC0l/dnSmZhJ7Z1KmEWilro/gOrjtOxqRQutlIqG22TaqoPGfYVN+en3Zwbt97kcgZDwqbuykNt64oZWc4XKCa3mprEGC3IbJTBFqglXmZ7l9ywGEEUJYOlb2XrSuPWml39beWdKM8kzr1OjnlOm6+lpTRCBfo0wa9F8YZRhHPAkwKkXXDeOGpWRj4ohOx0d2GWkyV5xyN14p2tQOCdOODmz80yUTgRpPVQUtOEhXQARAQABtCFBV1MgQ0xJIFRlYW0gPGF3cy1jbGlAYW1hem9uLmNvbT6JAlQEEwEIAD4WIQT7Xbd/1cEYuAURraimMQrMRnJHXAUCXYKvtQIbAwUJB4TOAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCmMQrMRnJHXJIXEAChLUIkg80uPUkGjE3jejvQSA1aWuAMyzy6fdpdlRUz6M6nmsUhOExjVIvibEJpzK5mhuSZ4lb0vJ2ZUPgCv4zs2nBd7BGJMxKiWgBReGvTdqZ0SzyYH4PYCJSE732x/Fw9hfnh1dMTXNcrQXzwOmmFNNegG0Oxau+VnpcR5Kz3smiTrIwZbRudo1ijhCYPQ7t5CMp9kjC6bObvy1hSIg2xNbMAN/DoikebAl36uA6Y/Uczjj3GxZW4ZWeFirMidKbtqvUz2y0UFszobjiBSqZZHCreC34Bhw9bFNpuWC/0SrXgohdsc6vK50pDGdV5kM2qo9tMQ/izsAwTh/d/GzZv8H4lV9eOtEis+EpR497PaxKKh9tJf0N6Q1YLRHof5xePZtOIlS3gfvsH5hXA3HJ9yIxb8T0HQYmVr3aIUes20i6meI3fuV36VFupwfrTKaL7VXnsrK2fq5cRvyJLNzXucg0WAjPFRrAGLzY7nP1xeg1a0aeP+pdsqjqlPJom8OCWc1+6DWbg0jsC74WoesAqgBItODMBrsal1y/q+bPzpsnWjzHV8+1/EtZmSc8ZUGSJOPkfC7hObnfkl18h+1QtKTjZme4dH17gsBJr+opwJw/Zio2LMjQBOqlm3K1A4zFTh7wBC7He6KPQea1p2XAMgtvATtNeYLZATHZKTJyiqA===vYOk

-----END PGP PUBLIC KEY BLOCK-----" > publicAWSValidator.txt

gpg --import publicAWSValidator.txt
verificationResult=$(gpg --verify awscliv2.sig awscliv2.zip 2>&1)
echo "$verificationResult"

if [[ $verificationResult == *"Good signature from"* ]];
then
  echo "Installation file verified. Installing the AWS CLI."
  unzip awscliv2.zip #  > /dev/null 2>&1
  ./aws/install #  > /dev/null 2>&1
  echo "AWS CLI installation details"
  aws --version # If installation fails, remove redirection to null
else
  echo "The installation file was invalid. Please investigate."
  exit 1 # unspecified error
fi

endTime=$(date +%s)
# shellcheck disable=SC2004
runTimeSecs=$(($endTime -$startTime))

echo -e "Finished installing the AWS CLI. Took $runTimeSecs seconds"
