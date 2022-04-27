" カラー
" Plug 'cocopon/iceberg.vim' | call add(g:defers, 'call plugins#iceberg#load()')
Plug 'rebelot/kanagawa.nvim' | call add(g:defers, 'call plugins#kanagawa#load()')

" fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' | call add(g:defers, 'call plugins#telescope#load()')

" ファイラー
Plug 'obaland/vfiler.vim' | call add(g:defers, 'call plugins#vfiler#load()')
Plug 'obaland/vfiler-column-devicons'

" 外見
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim' | call add(g:defers, 'call plugins#lualine#load()')
Plug 'mvllow/modes.nvim' | call add(g:defers, 'call plugins#modes#load()')

" 統合
call plugins#gitgutter#init() | Plug 'airblade/vim-gitgutter' | call add(g:defers, 'call plugins#gitgutter#load()')
Plug 'tpope/vim-fugitive'
