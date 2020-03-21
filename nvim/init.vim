set nocompatible
scriptencoding utf-8

set runtimepath^=~/.config/nvim

augroup MyAutoCmd
	autocmd!
augroup END

command! ReloadVimrc source $MYVIMRC

" 基本設定
source ~/.config/nvim/basic.vim

" 外見
source ~/.config/nvim/appearance.vim

" 編集
source ~/.config/nvim/edit.vim

" プラグイン
source ~/.config/nvim/plugin.vim
