function! plugins#BackAndForward#load()
	nnoremap <silent> <C-h> <Plug>(backandforward-back)
	nnoremap <silent> <C-l> <Plug>(backandforward-forward)
endfunction
