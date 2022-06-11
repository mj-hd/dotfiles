" カラー
Plug 'rebelot/kanagawa.nvim' | call add(g:defers, 'call plugins#kanagawa#load()')

" fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' | call add(g:defers, 'call plugins#telescope#load()')
Plug 'nvim-telescope/telescope-ui-select.nvim'

" ファイラー
Plug 'obaland/vfiler.vim' | call add(g:defers, 'call plugins#vfiler#load()')
Plug 'obaland/vfiler-column-devicons'

" 外見
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim' | call add(g:defers, 'call plugins#lualine#load()')
Plug 'mvllow/modes.nvim' | call add(g:defers, 'call plugins#modes#load()')
Plug 'rcarriga/nvim-notify' | call add(g:defers, 'call plugins#notify#load()')

" 統合
call plugins#gitgutter#init() | Plug 'airblade/vim-gitgutter' | call add(g:defers, 'call plugins#gitgutter#load()')
Plug 'tpope/vim-fugitive'

" 編集
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-sandwich'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tommcdo/vim-exchange'
Plug 'mg979/vim-visual-multi'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-expand-region' | call add(g:defers, 'call plugins#expandregion#load()')

" スクロールバー
Plug 'ojroques/vim-scrollstatus'

" 移動/検索
Plug 'rhysd/clever-f.vim'
Plug 'markonm/traces.vim'
Plug 'hrsh7th/vim-searchx' | call add(g:defers, 'call plugins#searchx#load()')
Plug 'Bakudankun/BackAndForward.vim' | call add(g:defers, 'call plugins#BackAndForward#load()')
Plug 'haya14busa/vim-edgemotion' | call add(g:defers, 'call plugins#edgemotion#load()')

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer' | call add(g:defers, 'call plugins#nvim_lsp#load()')
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp' | call add(g:defers, 'call plugins#nvim_cmp#load()')
Plug 'hrsh7th/cmp-buffer'
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/flutter-tools.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim' | call add(g:defers, 'call plugins#signature#load()')
Plug 'nvim-lua/lsp-status.nvim'

" スニペット
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} | au VimEnter * call plugins#treesitter#load()

" launcher
Plug 'skywind3000/asyncrun.vim' | call add(g:defers, 'call plugins#asyncrun#load()')
