#!/bin/bash

if [ ! -f ~/.config/fish/functions/fisher.fish ]; then
  echo -e "\e[31m>> Starting to install fisher... \e[m"
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fi
