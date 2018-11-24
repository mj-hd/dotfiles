#!/bin/bash

if [ ! -d ~/.zplug ]; then
	echo -e "\e[31m>> Starting to install zplug...\e[m"
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
