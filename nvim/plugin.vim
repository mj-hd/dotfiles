let s:cache_dir = expand('~/.cache/nvim')
let s:plug_file = s:cache_dir . '/autoload/plug.vim'

if empty(glob(s:plug_file))
	execute '!curl -fLo ' . s:plug_file . '  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

execute 'set runtimepath^=' . s:cache_dir

let g:defers = []

call plug#begin(s:cache_dir)

source ~/.dotfiles/nvim/plugin.common.vim

" 今後プラグインを分岐する必要あれば追記

call plug#end()

for defer in defers
	execute defer
endfor
