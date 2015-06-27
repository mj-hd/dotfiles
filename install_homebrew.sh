#!/bin/bash

if [ "$(uname)" != 'Darwin' ]; then
	exit 1
fi

echo -e "\e[31m>> Starting to install homebrew... \e[m"
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo -e "\e[31m>> Updating homebrew...\e[m"
brew update

echo -e "\e[31m>> Installing packages...\e[m"
brew install brew-cask go the_silver_searcher fish vim git sbcl mysql wget

echo -e "\e[31m>> Installing apps...\e[m"
brew install Caskroom/cask/totalspaces Caskroom/cask/bartender Caskroom/cask/caffeine Caskroom/cask/macs-fan-control Caskroom/cask/karabiner Caskroom/cask/iterm2 Caskroom/cask/mplayerx Caskroom/cask/the-unarchiver Caskroom/cask/imageoptim Caskroom/cask/firefox Caskroom/cask/sequel-pro Caskroom/cask/dropbox
