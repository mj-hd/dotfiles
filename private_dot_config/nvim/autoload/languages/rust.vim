function! languages#rust#load()
	nnoremap <silent> <leader>dt :call languages#rust#run_debug(1, 0)<cr>
	nnoremap <silent> <leader>dd :call languages#rust#run_debug(0, 0)<cr>
	nnoremap <silent> <leader>rt :call languages#rust#run_release(1, 0)<cr>
	nnoremap <silent> <leader>rr :call languages#rust#run_release(0, 0)<cr>
endfunction

function! languages#rust#cargo(cmd, tab, background)
	if a:background
		call plugins#notify#command(['cargo', a:cmd], [])
		return
	endif

	let l:opts = ''

	if a:tab
		let l:opts = '-mode=term -pos=tab'
	else
		let l:opts = '-mode=term -pos=bottom'
	endif

	let g:task_name = 'cargo ' . a:cmd
	exec 'AsyncRun ' . l:opts . ' -cwd=<root> -name=' . a:cmd . ' cargo ' . a:cmd
endfunction

function! languages#rust#run_debug(tab, background)
	call languages#rust#cargo("run", a:tab, a:background)
endfunction

function! languages#rust#run_release(tab, background)
	call languages#rust#cargo("run --release", a:tab, a:background)
endfunction
