function! plugins#registers#load()
	inoremap <silent> <c-v> <cmd>Registers i<cr>
	nnoremap <silent> <c-s-v> <cmd>Registers n<cr>
	xnoremap <silent> <c-s-v> <cmd>Registers v<cr>
endfunction
