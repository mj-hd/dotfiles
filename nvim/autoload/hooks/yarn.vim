function! hooks#yarn#init()
	" coffee break
	nmap <space><space><space> :call hooks#yarn#coffeebreak()<cr>

	" tabs
	nmap <space><space>d :call hooks#yarn#exec('dev', 1, 0)<cr>
	nmap <space><space>s :call hooks#yarn#exec('ui-catalog', 1, 0)<cr>
	nmap <space><space>t :call hooks#yarn#exec('test', 1, 0)<cr>
	nmap <space><space>c :call hooks#yarn#exec('typecheck', 1, 0)<cr>
	nmap <space><space>l :call hooks#yarn#exec('lint', 1, 0)<cr>
	nmap <space><space>f :call hooks#yarn#exec('format', 1, 0)<cr>

	" animate
	nmap <space>j :call hooks#yarn#terminal()<cr>
	nmap <space>d :call hooks#yarn#exec('dev', 0, 1)<cr>
	nmap <space>s :call hooks#yarn#exec('ui-catalog', 0, 1)<cr>
	nmap <space>t :call hooks#yarn#exec('test:unit:watch ' . expand('%:p:h'), 0, 1)<cr>
	nmap <space>c :call hooks#yarn#exec('typecheck', 0, 1)<cr>
	nmap <space>l :call hooks#yarn#exec('lint', 0, 1)<cr>
	nmap <space>f :call hooks#yarn#exec('format', 0, 1)<cr>


endfunction

function! hooks#yarn#coffeebreak()
	call hooks#yarn#exec('test', 1, 0)
	call hooks#yarn#exec('lint', 1, 0)
	call hooks#yarn#exec('typecheck', 1, 0)
endfunction

function! hooks#yarn#exec(cmd, tab, animate)
	if a:tab
		exec ":tabnew"
	else
		new
	endif
	set nonumber
	exec ":terminal yarn " . a:cmd
	if a:animate
		call hooks#yarn#animate()
	endif
endfunction

function! hooks#yarn#terminal()
	new
	set nonumber
	exec ":terminal"
	call hooks#yarn#animate()
endfunction

function! hooks#yarn#animate()
	wincmd J | resize 1
	call animate#window_percent_height(0.20)
endfunction
