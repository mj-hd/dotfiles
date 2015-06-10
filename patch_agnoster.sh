#!/bin/bash

echo -e "\e[31m>> Patching agnoster.theme to adapt to old powerline font...\e[m"

if [ -d ~/.oh-my-zsh ]; then
  pushd ~/.oh-my-zsh/
  pushd themes
  patch < ~/dotfiles/agnoster.patch
  popd
  popd
fi

if [ -d ~/.oh-my-fish ]; then
  pushd ~/.oh-my-fish/
  pushd themes
  pushd agnoster
  patch < ~/dotfiles/agnoster_fish.patch
  popd
  popd
  popd
fi

echo ""
