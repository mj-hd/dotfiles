function! hooks#github#init()
	nmap <space>g :call hooks#github#status()<cr>
	nmap <space>o :call hooks#github#open()<cr>
endfunction

function! hooks#github#status()
	exec ":tabnew"
	exec ":terminal gh pr status"
endfunction

function! hooks#github#open()
	exec ":tabnew"
	exec ":terminal gh pr view"
endfunction
