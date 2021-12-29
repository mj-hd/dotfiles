" 編集
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-sandwich'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tommcdo/vim-exchange'
Plug 'mg979/vim-visual-multi'
Plug 'tomtom/tcomment_vim'

" スクロールバー
Plug 'ojroques/vim-scrollstatus'

" 検索
Plug 'rhysd/clever-f.vim'
Plug 'markonm/traces.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer' | call add(g:defers, 'call plugins#nvim_lsp#load()')
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp' | call add(g:defers, 'call plugins#nvim_cmp#load()')
Plug 'hrsh7th/cmp-buffer'

" スニペット
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
