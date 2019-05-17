function! hooks#fzf#init()
	fun! FzfOmniFiles()
		let is_git = system('git status')
		if v:shell_error
			:Files
		else
			:GitFiles
		endif
	endfun
	
	nnoremap <C-b> :Buffers<CR>
	nnoremap <C-f> :Rg<CR>
	nnoremap <leader><leader> :Commands<CR>
	nnoremap <C-p> :call FzfOmniFiles()<CR>
endfunction
