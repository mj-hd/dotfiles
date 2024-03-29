function! plugins#coc#load()
	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

 	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

 	inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

 	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

 	" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
	" Coc only does snippet and additional edit on confirm.
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

 	" Use `[c` and `]c` for navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)
	
	nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
	nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

 	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	nmap <silent> ,r <Plug>(coc-refactor)
	nmap <silent> ,l <Plug>(coc-codelens-action)
	nmap <silent> ,g :CocSearch -w 

	" Sessions
	nmap <silent> <leader>q :CocCommand session.save<cr>
	nmap <silent> <leader>w :CocList sessions<cr>

	" Editor
	nmap <silent> <leader>r :CocCommand document.renameCurrentWord<cr>
	nmap <silent> <leader>o :CocCommand editor.action.organizeImport<cr>
	nmap <silent> <leader>. :CocAction quickfix<cr>
	nmap <silent> <leader>/ <Plug>(coc-codeaction-selected)
	xmap <silent> <leader>/ <Plug>(coc-codeaction-selected)

	let g:coc_snippet_next = '<c-l>'
	let g:coc_snippet_prev = '<c-k>'

	" Open explorer
	let g:coc_explorer_global_presets = {
		\   'floating': {
		\     'position': 'floating',
		\     'open-action-strategy': 'sourceWindow',
		\     'quit-on-open': v:true,
		\     'floating-width': -20,
		\     'floating-height': 20,
		\   },
		\ }
	nmap <silent> <leader>e :CocCommand explorer --preset floating --sources=file+<CR>

 	" Use K for show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>

 	function! s:show_documentation()
		if &filetype == 'vim'
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

 	" Highlight symbol under cursor on CursorHold
	autocmd CursorHold * silent call CocActionAsync('highlight')

 	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

		autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
		autocmd FileType coc-explorer setl nonumber
	augroup end

	" Use `:Format` for format current buffer
	command! -nargs=0 Format :call CocAction('format')

 	" Use `:Fold` for fold current buffer
	command! -nargs=? Fold :call CocAction('fold', <f-args>)

	set updatetime=100

	let g:coc_enable_locationlist = 1
endfunction
