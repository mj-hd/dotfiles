#!/bin/bash

echo -e "\e[31m>> Patching agnoster.theme to adapt to old powerline font...\e[m"
pushd ~/.oh-my-zsh/
pushd themes
patch < ~/dotfiles/agnoster.patch
popd
popd

echo ""
