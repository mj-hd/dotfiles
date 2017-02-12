#!/usr/bin

sudo apt-get update
sudo apt-get install aptitude
sudo aptitude install gnome-terminal uim-fep uim-anthy

mv ~/.bashrc ~/.bashrc.bak
ln -s ~/dotfiles/.wsl_bashrc ~/.bashrc

ln -s ~/dotfiles/.uim ~/.uim
