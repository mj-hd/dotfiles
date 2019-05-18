" 編集
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
