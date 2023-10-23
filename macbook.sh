#!/bin/bash

curl -O https://raw.githubusercontent.com/Homebrew/install/master/install.sh
chmod +x install.sh
#./install.sh
bash install.sh
brew analytics off
export HOMEBREW_NO_ANALYTICS=1
brew analytics

(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/eeeadmin/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install --cask xquartz
sudo /usr/bin/dscl . -delete "/Users/student"
