#!/bin/bash

curl -O https://raw.githubusercontent.com/Homebrew/install/master/install.sh
chmod +x install.sh
#./install.sh
sudo mkdir /usr/local/var/homebrew
sudo chown -R primeadmin /usr/local/var/homebrew
bash install.sh
brew analytics off
export HOMEBREW_NO_ANALYTICS=1
brew analytics

(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/eeeadmin/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install --cask xquartz
sudo dseditgroup -o edit -d "student" -t user admin
