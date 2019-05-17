if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

set nocompatible
scriptencoding utf-8

set shortmess=a
set cmdheight=2

augroup MyAutoCmd
	autocmd!
augroup END

set sh=zsh

set termguicolors

tnoremap <silent> <ESC> <C-\><C-n>

" dein settings {{{
if &compatible
	set nocompatible
endif

set runtimepath^=~/.config/nvim

" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:dein#install_process_timeout = 300

" なければgit clone
if !isdirectory(s:dein_repo_dir)
	execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	" 管理するプラグインを記述したファイル
	let s:toml = '~/.config/nvim/dein.toml'
	let s:lazy_toml = '~/.config/nvim/dein_lazy.toml'
	call dein#load_toml(s:toml, {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

" ---------------------------------
" 外見
" ---------------------------------
syntax on
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

" タブ
set ts=4 sw=4
set softtabstop=4
set noexpandtab

set notitle
set showmatch
set showcmd
set wrap
set number
set ruler
set cmdheight=2
set list
set listchars=tab:»_,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set laststatus=2
set wildmenu
set wildmode=full:list

set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L

set showtabline=2

" set breakindent

" --------------------------------
" 編集
" --------------------------------
let mapleader=","
set autoindent
set backspace=indent,eol,start
set clipboard+=unnamedplus
set pastetoggle=<F12>
set guioptions+=a
set mouse=a
if has("mouse_sgr")
	set ttymouse=sgr
endif
set completeopt=menu,preview
set tags+=.git/tags
set tags+=./tags

" 行内でもカーソル移動可能に
nnoremap <Down> gj
nnoremap <Up>   gk

" split系
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Denite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

" インクリメントデクリメント
nnoremap - <C-x>
nnoremap + <C-a>

nmap <Tab> %
vmap <Tab> %

" --------------------------------
" エンコーディング
" --------------------------------
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fenc=utf-8
set enc=utf-8

" -------------------------------
" 検索
" -------------------------------
set smartcase
set nohlsearch
set incsearch

" ------------------------------
" エクスプローラ
" ------------------------------
let g:explDetailedHelp=0
let g:explWinSize=''
let g:explSplitBelow=1
let g:explUseSeparators=1

" ------------------------------
" バッファ
" ------------------------------
set hidden

" ------------------------------
" 言語
" ------------------------------
" Lisp
" for slimv
" let g:slimv_lisp = 'ros run'
" let g:slimv_impl = 'sbcl'
" autocmd BufNewFile,BufRead *.asd set filetype=lisp

" Golang
au BufNewFile,BufRead *.go set sw=8 noexpandtab ts=8 filetype=go
au BufNewFile,BufRead *.gox set sw=8 noexpandtab ts=8 filetype=go
au FileType go nmap <F6> <Plug>(go-build)
au FileType go nmap <F5> <Plug>(go-run)
au FileType go nmap <F7> <Plug>(go-test)
au FileType go compiler go

" set updatetime=100

" Haskell
autocmd FileType haskell :set expandtab

" C/C++
" vim-clang
" disable auto completion for vim-clang
" let g:clang_auto = 0
" 
" " default 'longest' can not work with neocomplete
" let g:clang_c_completeopt	 = 'menuone'
" let g:clang_cpp_completeopt = 'menuone'
" 
" if executable('clang-3.6')
" 	let g:clang_exec = 'clang-3.6'
" elseif executable('clang-3.5')
" 	let g:clang_exec = 'clang-3.5'
" elseif executable('clang-3.4')
" 	let g:clang_exec = 'clang-3.4'
" else
" 	let g:clang_exec = 'clang'
" endif
" 
" if executable('clang-format-3.6')
" 	let g:clang_format_exec = 'clang-format-3.6'
" elseif executable('clang-format-3.5')
" 	let g:clang_format_exec = 'clang-format-3.5'
" elseif executable('clang-format-3.4')
" 	let g:clang_format_exec = 'clang-format-3.4'
" else
" 	let g:clang_exec = 'clang-format'
" endif

let g:clang_cpp_options = '-std=c++14 -stdlib=libc++'

" HSP
" autocmd BufNewFile,BufRead *.hsp call FileTypeHsp()
" function FileTypeHsp()
" 	compiler hsp
" 	set filetype=hsp
" 	noremap <F1> :execute "OpenBrowser http://ohdl.hsproom.me/?q=" . expand( "<cword>" )<CR>
" 	noremap <F5> :make<CR>
" 	set noexpandtab
" endfunction

" Javascript/TypeScript
" vim-js-indent
" let g:js_indent_typescript = 1
" 
" if has("nvim")
" 	autocmd FileType typescript setlocal completeopt-=menu
" 	let g:tsuquyomi_completion_detail = 1
" 	let g:tsuquyomi_disable_quickfix = 1
" 	let g:syntastic_typescript_checkers = ['tsuquyomi']
" endif

" ------------------------------
" その他
" ------------------------------
" 開いたファイルのディレクトリへ移動
au BufEnter * execute ":lcd " . escape(expand("%:p:h"), " #\\")
set timeoutlen=1000 ttimeoutlen=0
set autowrite

" md as markdown
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=mkd

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

au BufNewFile,BufRead *.js set sw=2 expandtab ts=2
au BufNewFile,BufRead *.jsx set sw=2 expandtab ts=2

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python3_host_skip_check = 1

let g:loaded_sql_completion = 0
