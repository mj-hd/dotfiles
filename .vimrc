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
NeoBundle 'kien/ctrlp.vim.git'       " Ctrl+pでファイル検索してくれるすごいの
NeoBundle 'scrooloose/nerdtree.git'  " ファイラ
NeoBundle 'scrooloose/syntastic.git' " 
NeoBundle 'itchyny/lightline.vim' " おしゃれ
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin'  : 'make -f make_cygwin.mak',
  \     'mac'     : 'make -f make_mac.mak',
  \     'unix'    : 'make -f make_unix.mak',
  \   },
  \ }
NeoBundle 'Shougo/vimshell.vim'  " 暗黒美夢王
NeoBundle 'Shougo/neomru.vim'  " 暗黒美夢王
NeoBundle 'jpo/vim-railscasts-theme' " テーマ
NeoBundle 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}}  " golang用
NeoBundle 'ervandew/supertab'            " 補完
NeoBundle 'Shougo/unite.vim'             " なんかすごいやつ
NeoBundle 'Shougo/vimfiler.vim'          " 高機能ファイラ
NeoBundle 'kovisoft/slimv'          " lisp用
NeoBundle 'toyamarinyon/vim-swift'  " swift対応
NeoBundle 'plasticboy/vim-markdown' " markdown対応
NeoBundle 'airblade/vim-gitgutter' " gitの変更点を表示
NeoBundle 'tpope/vim-fugitive'     " Gwrite, Greadでgitのadd, reset
NeoBundle 'junegunn/vim-easy-align' " 選んでReturn, spaceで整形
NeoBundle 'rking/ag.vim' " :Ag で検索
NeoBundle 'mhinz/vim-startify' " 起動画面を便利に

call neobundle#end()


" ---------------------------------
" 外見
" ---------------------------------
syntax on
colorscheme railscasts

" 全角空白をハイライト
if has("syntax")
    syntax on
 
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
endif

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
set clipboard=unnamed
set pastetoggle=<F12>
set guioptions+=a
set mouse=a
set ttymouse=xterm2
set completeopt=menu,preview

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
au BufEnter * execute ":lcd " . escape(expand("%:p:h"), " #\\")

" omnifuncがどうとかいうエラーの対処
setlocal omnifunc=syntaxcomplete#Complete
 autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
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
    return strlen(_) ? '⭠ '._ : ''
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
nnoremap <silent> <space><space> :<C-u>Unite file_rec/async:!<cr>
nnoremap <silent> <space>y :<C-u>Unite history/yank<cr>
nnoremap <silent> <space>b :<C-u>Unite buffer<cr>
nnoremap <silent> <space>r :<C-u>Unite file_mru buffer<cr>

" Ag
" --- type ~ to search the word in all files in the current dir
nmap ~ :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag

" gitgutter
highlight clear SignColumn

" startify
let g:startify_files_number = 5
let g:startify_list_order = [
        \ ['   最近使ったファイル:'],
        \ 'files',
        \ ['   最近使ったファイル(カレントディレクトリ下):'],
        \ 'dir',
        \ ['   セッション:'],
        \ 'sessions',
        \ ['   ブックマーク:'],
        \ 'bookmarks',
        \ ]
let g:startify_custom_header =
  \ map(split(system('~/dotfiles/meigen.rb | ~/dotfiles/cowsay'), '\n'), '"   ". v:val') + ['','']
let g:startify_bookmarks = ["~/.vimrc"]

" 自動的に閉じ括弧を入力
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
