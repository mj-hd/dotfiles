" 基本設定
if exists('$SHELL')
	set shell=$SHELL
else
	set shell=/bin/sh
endif

set shortmess=a
set cmdheight=2

augroup MyAutoCmd
	autocmd!
augroup END

set sh=zsh

set termguicolors
set hidden
