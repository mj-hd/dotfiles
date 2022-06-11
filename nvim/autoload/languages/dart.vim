function! s:trigger_hot_reload() abort
    silent exec '!kill -SIGUSR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null'
endfunction

function! s:trigger_hot_restart() abort
    silent exec '!kill -SIGUSR2 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null'
endfunction

function! languages#dart#load()
	command! FlutterHotReload call s:trigger_hot_reload()
	command! FlutterHotRestart call s:trigger_hot_restart()
	
	nnoremap <leader><leader> :FlutterHotReload<cr>
	nnoremap <silent> <leader>s :call languages#dart#melos('gen:all', 0, 1)<cr>
	nnoremap <silent> <leader>l :call languages#dart#melos('gen:l10n', 0, 1)<cr>
	nnoremap <silent> <leader>p :call languages#dart#melos('pub:get', 0, 1)<cr>
	nnoremap <silent> <leader>a :call languages#dart#melos('analyze', 1, 0)<cr>
	nnoremap <silent> <leader>f :call languages#dart#melos('format', 0, 1)<cr>
	nnoremap <silent> <leader><tab> <cmd>lua require('telescope').extensions.flutter.commands()<cr>
endfunction

function! languages#dart#melos(cmd, tab, background)
	if a:background
		call plugins#notify#command(['melos', 'run ' . a:cmd ], [])
		return
	endif

	let l:opts = ''

	if a:tab
		let l:opts = '-mode=term -pos=tab'
	else
		let l:opts = '-mode=term -pos=bottom'
	endif

	let g:task_name = 'melos run ' . a:cmd
	exec 'AsyncRun ' . l:opts . ' -cwd=<root> -name=' . a:cmd . ' melos run ' . a:cmd
endfunction
