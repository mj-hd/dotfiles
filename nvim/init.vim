set nocompatible
scriptencoding utf-8
set runtimepath^=~/.config/nvim

" 基本設定
call configs#basic#init()

" dein読み込み
call configs#dein#init()

" 外見
call configs#appearance#init()

" 編集
call configs#edit#init()

" エンコーディング
call configs#encoding#init()

" 検索
call configs#search#init()

" エクスプローラ
call configs#explorer#init()

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

" ------------------------------
" その他
" ------------------------------
" terminalでESC
tnoremap <silent> <ESC> <C-\><C-n>

" 開いたファイルのディレクトリへ移動
au BufEnter * execute ":lcd " . escape(expand("%:p:h"), " #\\")
set timeoutlen=1000 ttimeoutlen=0
set autowrite

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python3_host_skip_check = 1
