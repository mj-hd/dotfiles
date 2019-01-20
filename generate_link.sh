#!/bin/bash

ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vim ~/.nvim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vimrc ~/.nvimrc
ln -s ~/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmux-powerline ~/.tmux-powerline
ln -s ~/dotfiles/.tmux-powerlinerc ~/.tmux-powerlinerc
ln -s ~/dotfiles/.tigrc ~/.tigrc

mkdir -p ~/.config/fish/
ln -s ~/dotfiles/fishfile ~/.config/fish/fishfile
ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish

ln -s ~/dotfiles/.vim ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/.dein.toml ~/.dein.toml
ln -s ~/dotfiles/.dein_lazy.toml ~/.dein_lazy.toml
