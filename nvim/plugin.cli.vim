" カラー
Plug 'cocopon/iceberg.vim' | au VimEnter * call plugins#iceberg#load() 

" fuzzy finder
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' } | au VimEnter * call plugins#vimclap#load()

" coc 連携
Plug 'vn-ki/coc-clap'

" 外見
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim' | call plugins#lightline#load()
" Plug 'camspiers/animate.vim' | call plugins#animate#load()

" 統合
let g:gitgutter_map_keys = 0
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
