let s:cache_dir = expand('~/.cache/nvim')
let s:plug_file = s:cache_dir . '/autoload/plug.vim'

if empty(glob(s:plug_file))
	execute '!curl -fLo ' . s:plug_file . '  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

execute 'set runtimepath^=' . s:cache_dir

call plug#begin(s:cache_dir)

" カラー
Plug 'cocopon/iceberg.vim' | au VimEnter * call plugins#iceberg#load() 

" 編集
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-sandwich'
Plug 'ConradIrwin/vim-bracketed-paste'

" 検索
Plug 'rhysd/clever-f.vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' } | au VimEnter * call plugins#vimclap#load()

" LSP
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} | au VimEnter * call plugins#coc#load()
Plug 'neoclide/coc-json', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn --frozen-lockfile'}

" coc 連携
Plug 'vn-ki/coc-clap'

" 外見
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim' | call plugins#lightline#load()
Plug 'camspiers/animate.vim' | call plugins#animate#load()

" 統合
let g:gitgutter_map_keys = 0
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mcchrish/nnn.vim' | au VimEnter * call plugins#nnn#load()
au VimEnter * call plugins#yarn#load()

" シンタックス
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/context_filetype.vim'

" Web
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'chemzqm/vim-jsx-improve', {'for': ['javascript', 'typescript', 'typescript.tsx']}
Plug 'heavenshell/vim-syntax-flowtype', {'for': ['javascript']}
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}

call plug#end()

execute 'set runtimepath^=~/Projects/vim-micromap'
