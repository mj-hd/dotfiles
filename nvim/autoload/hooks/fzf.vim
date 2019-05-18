function! hooks#fzf#init()
	nnoremap <C-b> :Buffers<CR>
	nnoremap <C-f> :Rg<CR>
	nnoremap <leader><leader> :Commands<CR>
	nnoremap <C-p> :call hooks#fzf#omni_files()<CR>
endfunction

function! hooks#fzf#omni_files()
	let is_git = system('git status')
	if v:shell_error
		:Files
	else
		:GitFiles
	endif
endfunction
