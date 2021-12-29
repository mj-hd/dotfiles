function! languages#js#load()
	" coffee break
	nmap <leader><leader><leader> :call languages#js#coffeebreak()<cr>

	" tabs
	nmap <leader><leader>d :call languages#js#exec('dev', 1, 0)<cr>
	nmap <leader><leader>s :call languages#js#exec('ui-catalog', 1, 0)<cr>
	nmap <leader><leader>t :call languages#js#exec('test', 1, 0)<cr>
	nmap <leader><leader>c :call languages#js#exec('typecheck', 1, 0)<cr>
	nmap <leader><leader>l :call languages#js#exec('lint', 1, 0)<cr>
	nmap <leader><leader>f :call languages#js#exec('format', 1, 0)<cr>
endfunction

function! languages#js#coffeebreak()
	call languages#js#exec('test', 1, 0)
	call languages#js#exec('lint', 1, 0)
	call languages#js#exec('typecheck', 1, 0)
endfunction

function! languages#js#exec(cmd, tab, animate)
	if a:tab
		exec ":tabnew"
	else
		new
	endif
	set nonumber
	exec ":terminal yarn " . a:cmd
	if a:animate
		call languages#js#animate()
	endif
endfunction

function! languages#js#terminal()
	new
	set nonumber
	exec ":terminal"
	call languages#js#animate()
endfunction

function! languages#js#animate()
	wincmd J | resize 1
	call animate#window_percent_height(0.20)
endfunction
