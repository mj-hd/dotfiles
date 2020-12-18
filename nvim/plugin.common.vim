" 編集
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-sandwich'
Plug 'ConradIrwin/vim-bracketed-paste'

" 検索
Plug 'rhysd/clever-f.vim'

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
Plug 'weirongxu/coc-explorer', {'do': 'yarn --frozen-lockfile'}
Plug 'voldikss/vim-skylight' | call plugins#skylight#load()
