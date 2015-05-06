#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
  echo -e "\e[31m>> Starting to install oh-my-zsh...\e[m"
  curl -L http://install.ohmyz.sh | sh
fi

echo ""
