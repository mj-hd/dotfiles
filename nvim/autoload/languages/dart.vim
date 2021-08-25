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
	nnoremap <silent> <leader>d :call languages#dart#exec('run:dev', 1, 0)<cr>
	nnoremap <silent> <leader>s :call languages#dart#exec('develop', 1, 0)<cr>
	nnoremap <silent> <leader>l :CocCommand flutter.emulators<cr>
	nnoremap <silent> <leader><cr> :call languages#dart#coffeebreak()<cr>
endfunction

" TODO refactor
function! languages#dart#exec(cmd, tab, animate)
	if a:tab
		exec ":tabnew"
	else
		new
	endif
	set nonumber
	exec ":terminal melos run " . a:cmd
	if a:animate
		call languages#dart#animate()
	endif
endfunction

function! languages#dart#coffeebreak()
	call languages#dart#exec('analyze', 1, 0)
endfunction

function! languages#dart#terminal()
	new
	set nonumber
	exec ":terminal"
	call languages#dart#animate()
endfunction

function! languages#dart#animate()
	wincmd J | resize 1
	call animate#window_percent_height(0.20)
endfunction
