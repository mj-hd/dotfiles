function! hooks#vimlsp#init()
	call hooks#vimlsp#ts()
	call hooks#vimlsp#go()
	call hooks#vimlsp#ruby()
	call hooks#vimlsp#docker()

	nmap <silent> <space>k :LspPreviousError<CR>
	nmap <silent> <space>j :LspNextError<CR>
	
	nmap <silent> gd :LspDefinition<CR>
	nmap <silent> gy :LspTypeDefinition<CR>
	nmap <silent> gi :LspImplementation<CR>
	nmap <silent> gr :LspReferences<CR>
	
	nnoremap <silent> K :LspHover<CR>
	
	nmap <leader>rn :LspRename<CR>
	
	vmap <leader>f :LspDocumentRangeFormat<CR>
	nmap <leader>f :LspDocumentFormat<CR>

	nmap <leader>a :LspCodeAction<CR>
	
	" :Format割り当て
	command! -nargs=0 Format :LspDocumentFormat

	" diagnostics
	let g:lsp_signs_enabled = 1
	let g:lsp_diagnostics_echo_cursor = 1
	let g:lsp_signs_error = {'text': '✗'}
	let g:lsp_signs_warning = {'text': '‼'}
	let g:lsp_signs_hint = {'text': 'ℹ︎'}
endfunction

function! hooks#vimlsp#ts()
	if !executable("typescript-language-server")
		return
	endif
	au User lsp_setup call lsp#register_server({
		\ 'name': 'typescript-language-server',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
		\ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
		\ 'whitelist': ['typescript', 'typescript.tsx'],
		\ })
endfunction

function! hooks#vimlsp#go()
	if !executable('gopls')
		return
	endif
	au User lsp_setup call lsp#register_server({
		\ 'name': 'gopls',
		\ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
		\ 'whitelist': ['go'],
		\ })
	autocmd BufWritePre *.go LspDocumentFormatSync
endfunction

function! hooks#vimlsp#ruby()
	if !executable('solargraph')
		return
	endif
	au User lsp_setup call lsp#register_server({
		\ 'name': 'solargraph',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
		\ 'initialization_options': {"diagnostics": "true"},
		\ 'whitelist': ['ruby'],
		\ })
endfunction

function! hooks#vimlsp#docker()
	if !executable('docker-langserver')
		return
	endif
	au User lsp_setup call lsp#register_server({
		\ 'name': 'docker-langserver',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
		\ 'whitelist': ['dockerfile'],
		\ })
endfunction
