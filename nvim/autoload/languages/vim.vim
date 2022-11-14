function! languages#vim#load()
	nnoremap <silent> <space>l :?lua << EOF?+1,/EOF/-1:Partedit -opener vsplit -filetype lua<cr>
endfunction
