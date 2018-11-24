set shell=/bin/bash 
set nocompatible
scriptencoding utf-8

set shortmess=a
set cmdheight=2

augroup MyAutoCmd
	autocmd!
augroup END

if has("nvim")
	set sh=zsh

	set termguicolors

	tnoremap <silent> <ESC> <C-\><C-n>

	" dein settings {{{
	if &compatible
		set nocompatible
	endif

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
		let s:toml = '~/.dein.toml'
		let s:lazy_toml = '~/.dein_lazy.toml'
		call dein#load_toml(s:toml, {'lazy': 0})
		call dein#load_toml(s:lazy_toml, {'lazy': 1})
	
		call dein#end()
		call dein#save_state()
	endif
	
	" その他インストールしていないものはこちらに入れる
	if dein#check_install()
		call dein#install()
	endif

else

	set term=screen-256color

endif

" ---------------------------------
" 外見
" ---------------------------------
syntax on
if has("nvim")
	let g:rehash256 = 1
	let g:molokai_original = 1
	colorscheme molokai
endif

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

set showtabline=2

" set breakindent

" --------------------------------
" 編集
" --------------------------------
let mapleader=","
set autoindent
set backspace=indent,eol,start
" set clipboard+=autoselect
set clipboard+=unnamedplus
set pastetoggle=<F12>
set guioptions+=a
set mouse=a
if has("mouse_sgr")
	set ttymouse=sgr
else
	if !has("nvim")
		set ttymouse=xterm2
	endif
endif
set completeopt=menu,preview
set tags+=.git/tags
set tags+=./tags

" 行内でもカーソル移動可能に
nnoremap <Down> gj
nnoremap <Up>	 gk

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
" 言語
" ------------------------------
" Lisp
" for slimv
" let g:slimv_lisp = 'ros run'
" let g:slimv_impl = 'sbcl'
" autocmd BufNewFile,BufRead *.asd set filetype=lisp

" Golang
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 filetype=go
au BufNewFile,BufRead *.gox set sw=4 noexpandtab ts=4 filetype=go
au FileType go nmap <F6> <Plug>(go-build)
au FileType go nmap <F5> <Plug>(go-run)
au FileType go nmap <F7> <Plug>(go-test)
au FileType go compiler go

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
au FileType go nmap <F1> <Plug>(go-def)

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
	filetype off
	filetype plugin indent off
endif
set runtimepath+=$GOROOT/misc/vim " replace $GOROOT with the output of: go env GOROOT
set rtp+=$GOPATH/src/github.com/mdempsky/gocode/vim
let g:deoplete#sources#go#gocode_binary="$GOPATH/src/github.com/mdempsky/gocode/vim"
filetype plugin indent on
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "snakecase"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "3s"
let g:go_auto_type_info = 0
let g:go_auto_sameids = 1
let g:go_fmt_fail_silently = 1
let g:go_snippet_engine = 'neosnippet'
set updatetime=100

nmap gdd :GoDefPop

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

" deoplete
if has("nvim")
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#sources#go#package_dot = 1
	let g:deoplete#sources#go#pointer = 1
endif

" ------------------------------
" その他
" ------------------------------
" 開いたファイルのディレクトリへ移動
au BufEnter * execute ":lcd " . escape(expand("%:p:h"), " #\\")
set timeoutlen=1000 ttimeoutlen=0
set autowrite

" ------------------------------
" プラグイン
" ------------------------------
" lightline
let g:lightline = {
	\ 'colorscheme': 'jellybeans',
	\ 'mode_map': { 'c': 'NORMAL' },
	\ 'active': {
	\	 'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
	\	 'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'], ['ale'] ]
	\ },
	\ 'component_function': {
	\	 'modified': 'MyModified',
	\	 'readonly': 'MyReadonly',
	\	 'fugitive': 'MyFugitive',
	\	 'filename': 'MyFilename',
	\	 'fileformat': 'MyFileformat',
	\	 'filetype': 'MyFiletype',
	\	 'fileencoding': 'MyFileencoding',
	\	 'mode': 'MyMode',
	\	 'ale': 'ALE'
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '|' }
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
		\	&ft == 'unite' ? unite#get_status_string() : 
		\	&ft == 'vimshell' ? vimshell#get_status_string() :
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
	return winwidth(0) > 70 ?
		\ (&fileformat == 'unix' ? '' :
		\ &fileformat == 'dos' ? '' :
		\ &fileformat == 'mac' ? '' : &fileformat) : ''
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ?
		\ (strlen(&filetype) ?
		\  (&filetype == 'go' ? '' :
		\   &filetype == 'typescript' ? '' :
		\   &filetype == 'typescript.jsx' ? 'TSX' :
		\   &filetype == 'javascript' ? '' :
		\   &filetype == 'vim' ? '' :
		\   &filetype == 'php' ? '' : &filetype) : '') : ''
endfunction

function! MyFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! ALE()
	let l:counts = ale#statusline#Count(bufnr(''))
	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors
	return l:counts.total == 0 ? ' ' : printf('ﮏ %d  %d', all_errors, all_non_errors)
endfunction

" md as markdown
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=mkd

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" gitgutter
highlight clear SignColumn

" startify
let g:startify_files_number = 5
let g:startify_list_order = [
	\ ['		 ♻	最近使ったファイル:'],
	\ 'files',
	\ ['		 ♲	最近使ったファイル(カレントディレクトリ下):'],
	\ 'dir',
	\ ['		 ⚑	セッション:'],
	\ 'sessions',
	\ ['		 ☺	ブックマーク:'],
	\ 'bookmarks',
	\ ]
let g:startify_bookmarks = ["~/.vimrc"]

function! s:filter_header(lines) abort
	let longest_line	 = max(map(copy(a:lines), 'len(v:val)'))
	let centered_lines = map(copy(a:lines),
		\ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
	return centered_lines
endfunction

nnoremap <silent> ! :Startify<CR>

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" vimshell
if !has("nvim")
	nnoremap <silent> vs :<C-u>VimShellPop<CR>
else
	nnoremap <silent> vs :terminal<CR>
endif

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

" VimFiler
let g:vimfiler_enable_auto_cd = 1

" tcomment
let g:tcommentMapLeader1 = '<C-/>'

" ale
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_error = "ﮏ"
let g:ale_sign_warning = ""
let g:ale_set_loclist = 0
hi ALEWarningSign ctermfg=Yellow
hi ALEErrorSign ctermfg=Red

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

au BufNewFile,BufRead *.js set sw=2 expandtab ts=2
au BufNewFile,BufRead *.jsx set sw=2 expandtab ts=2

let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_skip_check = 1

let g:loaded_sql_completion = 0

" FZF
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Rg<Space>
nnoremap <leader><leader> :Commands<CR>
nnoremap <C-p> :call FzfOmniFiles()<CR>

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#source_importer = 0
let g:deoplete#sources#go#gocode_binary = '~/.go/bin/gocode'
let g:deopelte#sources#go#unimported_packages = 1
let g:deoplete#sources#go#fallback_to_source = 1
