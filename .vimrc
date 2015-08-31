set shell=/bin/bash

set nocompatible
scriptencoding utf-8

" for neobundle
if has('vim_starting')
  filetype plugin off
  filetype indent off
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim.git' " これ

NeoBundleCheck
NeoBundle 'scrooloose/syntastic.git' " 
NeoBundle 'itchyny/lightline.vim' " おしゃれ

" Shougo
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin'  : 'make -f make_cygwin.mak',
  \     'mac'     : 'make -f make_mac.mak',
  \     'unix'    : 'make -f make_unix.mak',
  \   },
  \ }
NeoBundle 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }

NeoBundle 'jpo/vim-railscasts-theme' " テーマ
NeoBundle 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}}  " golang用
NeoBundle 'kovisoft/slimv'          " lisp用
NeoBundle 'toyamarinyon/vim-swift'  " swift対応
NeoBundle 'plasticboy/vim-markdown' " markdown対応
NeoBundle 'airblade/vim-gitgutter' " gitの変更点を表示
NeoBundle 'junegunn/vim-easy-align' " 選んでReturn, spaceで整形
NeoBundle 'rking/ag.vim' " :Ag で検索
NeoBundle 'mhinz/vim-startify' " 起動画面を便利に
NeoBundle 'Lokaltog/vim-easymotion' " 移動
NeoBundle 'mrtazz/simplenote.vim'
NeoBundle 'Raimondi/delimitMate'

NeoBundleLazy 'nosami/Omnisharp', {
	\   'autoload': {'filetypes': ['cs']},
	\   'build': {
	\     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
	\     'mac': 'xbuild server/OmniSharp.sln',
	\     'unix': 'xbuild server/OmniSharp.sln',
	\   }
	\ }


call neobundle#end()


" ---------------------------------
" 外見
" ---------------------------------
syntax on
colorscheme railscasts

" 全角空白をハイライト
" PODバグ対策
syn sync fromstart

function! ActivateInvisibleIndicator()
    " 下の行の"　"は全角スペース
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
    highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
    syntax match InvisibleTab "\t" display containedin=ALL
    highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
endf
augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
augroup END

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

" --------------------------------
" 編集
" --------------------------------
set autoindent
set backspace=indent,eol,start
set clipboard+=autoselect
set clipboard+=unnamed
set pastetoggle=<F12>
set guioptions+=a
set mouse=a
if !has("nvim")
    set ttymouse=xterm2
endif
set completeopt=menu,preview

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
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

" インクリメントデクリメント
nnoremap + <C-a>
nnoremap - <C-x>

nmap <Tab> %
vmap <Tab> %

" --------------------------------
" エンコーディング
" --------------------------------
set termencoding=utf-8
set encoding=japan
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fenc=utf-8
set enc=utf-8

" -------------------------------
" 検索
" -------------------------------
set smartcase
set nohlsearch
set incsearch

if v:version < 700
   set migemo
endif

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
" その他
" ------------------------------
" 開いたファイルのディレクトリへ移動
au BufEnter * execute ":lcd " . escape(expand("%:p:h"), " #\\")

" ------------------------------
" プラグイン
" ------------------------------
" lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" md as markdown
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" for slimv
let g:slimv_lisp = '/usr/local/bin/sbcl'

" for go
autocmd BufNewFile,BufRead *.go set filetype=go

" Go に付属の plugin と gocode を有効にする

" 保存時に :Fmt する
" autocmd FileType go autocmd BufWritePre <buffer> Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 filetype=go
au FileType go compiler go

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set runtimepath+=$GOROOT/misc/vim " replace $GOROOT with the output of: go env GOROOT
set rtp+=$GOPATH/src/github.com/nsf/gocode/vim
filetype plugin indent on
let g:gofmt_command = 'goimports'

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" unite
let g:unite_source_history_yank_enable = 1
try
	let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
	call unite#filters#matcher_default#use(['mathcer_fuzzy'])
	let g:unite_enable_start_insert = 1
	let g:unite_source_file_mru_limit = 200
catch
endtry

" search a file in the filetree
nnoremap <silent> ,<space> :<C-u>Unite file_rec/async:!<cr>
nnoremap <silent> ,y :<C-u>Unite history/yank<cr>
nnoremap <silent> ,b :<C-u>Unite buffer<cr>
nnoremap <silent> ,r :<C-u>Unite file_mru buffer<cr>

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" Ag
" --- type ~ to search the word in all files in the current dir
nmap ~ :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag

" gitgutter
highlight clear SignColumn

" startify
let g:startify_files_number = 5
let g:startify_list_order = [
        \ ['     ♻  最近使ったファイル:'],
        \ 'files',
        \ ['     ♲  最近使ったファイル(カレントディレクトリ下):'],
        \ 'dir',
        \ ['     ⚑  セッション:'],
        \ 'sessions',
        \ ['     ☺  ブックマーク:'],
        \ 'bookmarks',
        \ ]
let g:startify_bookmarks = ["~/.vimrc"]

function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
    let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction

let g:startify_custom_header = s:filter_header([
    \ '      ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁    ░▓▓▒         ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁',
    \ '     ▕                        ▁  ░░▓▓▒▒▒     ▁▔                        ▔▏',
    \ '    ▕ ▗▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚  ░░░▓▓▓▓▓▒▒▒  ▕ ▗▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▖▒▒',
    \ '    ▕ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒ ▓▓▓▓▓▓▓▓▓▒▒ ▕ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒',
    \ '    ▕ ▝▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚ ▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒ ▝▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▀▘▒',
    \ '     ▕     ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▏',
    \ '      ▔▔▔▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒  ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▒▒',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓   ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▒▓▓▒▒▒',
    \ '        ░▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓   ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▒▒▒',
    \ '       ░░▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒',
    \ '     ░░░▓▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒',
    \ '   ░░░▓▓▓▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒    ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒',
    \ ' ░░░▓▓▓▓▓▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒  ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒',
    \ '▒▒▒▓▓▓▓▓▓▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒',
    \ ' ▒▒▒▓▓▓▓▓▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████',
    \ '   ▒▒▒▓▓▓▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███',
    \ '     ▒▒▓▓▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▖▖▖▖▖▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███',
    \ '      ▒▒▒▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▚▚▚▚▚▘▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███',
    \ '       ▒▒▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒ ▚▚▚▚▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███',
    \ '        ▒▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▚▚▚▚▚▚▚▚▓▓▓▚▚▚▚▚▚▖▓▓▗▚▚▚▚▚▖██ ▗▚▚▚▚▚',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▓▓▓▚▚▚▚▘▓▓▓▓▓▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▓▓▓▓▚▚▚▚▚▎▓▓▓▓▓▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚▚',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▒▓▓▓▓▚▚▚▚▚▎▓▓▓▓▓▚▚▚▚▓▓▓▓▞▚▚▚▚▚      ▚▚▚▚▚',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▚▚▒▒▓▓▓▓▓▚▚▚▚▚▘▓▓▓▓▓▚▚▚▚▚▓▓██▞▚▚▚▚▚     ▚▚▚▚▚',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▚▚▒▒▒▒▓▓▓▓▓▚▚▚▚▚▘▓▓▓▓▚▚▚▚▚▓███  ▚▚▚▚      ▚▚▚▚▚',
    \ '         ▏ ▚▚▚▚▚▚▚▚▚▒▒▒▒▒▒▒▓▓▓▚▚▚▚▞▞▓▓▓▓▓▚▚▚▚▓██   ▚▚▚▚▚     ▚▚▚▚▚',
    \ '         ▏ ▚▚▚▚▚▚▒▒▒▒    ▒▒▒▒▚▚▚▚▚▚▓▓▓▓▓▚▚▚▚▚██    ▚▚▚▚     ▚▚▚▚▚▚',
    \ '         ▔▁▀▒▒▒▒▒▒         ▒▒▚▚▚▚▚▚▚▚▓▓▓▚▚▚▚▚▚    ▚▚▚▚▚▚    ▚▚▚▚▚▚▚',
    \ '           ▔                  ▒▒▓▓▓▓▓▓▓▓███',
    \ '                               ▒▒▒▓▓▓▓███',
    \ '                                 ▒▒▒▓██▓',
    \ '                                   ▒█▓',
    \ ])


autocmd FileType haskell :set expandtab

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

" neocomplete
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" vimshell
nmap <silent> vs :<C-u>VimShellPop<CR>

" vim-easymotion
let g:EasyMotion_do_mapping = 0
nmap f <Plug>(easymotion-s2)
xmap f <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map ,j <Plug>(easymotion-j)
map ,k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
hi EasyMotionTarget guifg=#80a0ff ctermfg=81

" simplenote
let g:SimplenoteUsername = "username"
let g:SimplenotePassword = "password"
let g:SimplenoteFiletype = "mkd"

nmap <silent> todo  :Simplenote -o ToDo<CR>

nmap <silent> memo  :Simplenote -l<CR>
nmap <silent> nmemo :Simplenote -n<CR>
nmap <silent> smemo :Simplenote -u<CR>
nmap <silent> dmemo :Simplenote -d<CR>
nmap <silent> Dmemo :Simplenote -D<CR>
nmap <silent> pmemo :Simplenote -p<CR>
nmap <silent> Pmemo :Simplenote -P<CR>
nmap <silent> tmemo :Simplenote -t<CR>

" OmniSharp
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:OmniSharp_selector_ui = 'unite'
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
