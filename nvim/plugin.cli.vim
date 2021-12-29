" カラー
Plug 'cocopon/iceberg.vim' | call add(g:defers, 'call plugins#iceberg#load()')

" fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' | call add(g:defers, 'call plugins#telescope#load()')
Plug 'nvim-telescope/telescope-file-browser.nvim'

" 外見
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim' | call add(g:defers, 'call plugins#lightline#load()')

" 統合
let g:gitgutter_map_keys = 0
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
