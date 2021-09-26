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
	nnoremap <silent> <leader>da :call languages#dart#dev_and()<cr>
	nnoremap <silent> <leader>di :call languages#dart#dev_ios()<cr>
	nnoremap <silent> <leader>s :call languages#dart#exec('develop', 1, 0)<cr>
	nnoremap <silent> <leader>l :CocCommand flutter.emulators<cr>
	nnoremap <silent> <leader><cr> :call languages#dart#coffeebreak()<cr>

	augroup dart
		autocmd!
	
		autocmd BufWinEnter output:///flutter-dev wincmd J | resize 3 | setlocal winfixheight | wincmd p
	augroup end
endfunction

" TODO refactor
function! languages#dart#exec(cmd, tab, animate)
	if a:tab
		exec ":tabnew"
	else
		new
	endif
	setlocal nonumber
	exec ":terminal melos run " . a:cmd
	if a:animate
		call languages#dart#animate()
	endif
endfunction

function! languages#dart#dev_and() abort
	exec ":CocCommand flutter.run --flavor development --dart-define=FLAVOR=development --target lib/main.dart -d sdk gphone64 arm64"
endfunction

function! languages#dart#dev_ios() abort
	exec ":CocCommand flutter.run --flavor development --dart-define=FLAVOR=development --target lib/main.dart -d iPhone 13"
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
