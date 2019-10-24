set nocompatible
scriptencoding utf-8
set runtimepath^=~/.config/nvim

" 基本設定
source ~/.config/nvim/basic.vim

" dein読み込み
source ~/.config/nvim/dein.vim

" 外見
source ~/.config/nvim/appearance.vim

" 編集
source ~/.config/nvim/edit.vim

" エンコーディング
source ~/.config/nvim/encoding.vim

" 検索
source ~/.config/nvim/search.vim

" エクスプローラ
source ~/.config/nvim/explorer.vim

" ------------------------------
" 言語
" ------------------------------
" Golang
au BufNewFile,BufRead *.go set sw=8 noexpandtab ts=8 filetype=go
au FileType go compiler go

" Haskell
au FileType haskell :set expandtab

" Markdown
au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=mkd

" JS/TS
au BufNewFile,BufRead *.js set sw=2 expandtab ts=2
au BufNewFile,BufRead *.jsx set sw=2 expandtab ts=2
au BufNewFile,BufRead *.ts set sw=2 expandtab ts=2

" json
au FileType json syntax match Comment +\/\/.\+$+
au BufNewFile,BufRead *.json set sw=2 expandtab ts=2 conceallevel=0

" yaml
au FileType yaml :set cursorcolumn

" ------------------------------
" その他
" ------------------------------
" terminalでESC
tnoremap <silent> <ESC> <C-\><C-n>

" htop
call hooks#htop#init()

" yarn
call hooks#yarn#init()

set timeoutlen=1000 ttimeoutlen=0
set autowrite

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python3_host_skip_check = 1
