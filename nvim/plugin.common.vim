" 編集
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-sandwich'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tommcdo/vim-exchange'

" チートシート系
Plug 'tversteeg/registers.nvim'

" 検索
Plug 'rhysd/clever-f.vim'

" LSP
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} | au VimEnter * call plugins#coc#load()
Plug 'neoclide/coc-json', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn --frozen-lockfile'}
Plug 'voldikss/vim-skylight' | call plugins#skylight#load()
Plug 'josa42/coc-go', {'do': 'yarn --frozen-lockfile'}
Plug 'iamcco/coc-flutter', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn --frozen-lockfile'}
