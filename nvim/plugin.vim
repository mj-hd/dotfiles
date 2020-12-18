let s:cache_dir = expand('~/.cache/nvim')
let s:plug_file = s:cache_dir . '/autoload/plug.vim'

if empty(glob(s:plug_file))
	execute '!curl -fLo ' . s:plug_file . '  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

execute 'set runtimepath^=' . s:cache_dir

call plug#begin(s:cache_dir)

source ~/.dotfiles/nvim/plugin.common.vim

if !exists('g:vscode')
	source ~/.dotfiles/nvim/plugin.cli.vim
endif

if has('nvim-0.5.0')
	source ~/.dotfiles/nvim/plugin.nvim-0.5.0.vim
else
	source ~/.dotfiles/nvim/plugin.nvim-legacy.vim
endif

call plug#end()

execute 'set runtimepath^=~/Projects/vim-picomap'
