#!/bin/bash

if [ ! -d ~/.oh-my-fish ]; then
  echo -e "\e[31m>> Starting to install oh-my-fish... \e[m"
  curl -L https://github.com/bpinto/oh-my-fish/raw/master/tools/install.fish | fish
fi

fish -c "omf install" -c "exit"
echo ""
