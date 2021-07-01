function! plugins#yarn#load()
	" coffee break
	nmap <leader><leader><leader> :call plugins#yarn#coffeebreak()<cr>

	" tabs
	nmap <leader><leader>d :call plugins#yarn#exec('dev', 1, 0)<cr>
	nmap <leader><leader>s :call plugins#yarn#exec('ui-catalog', 1, 0)<cr>
	nmap <leader><leader>t :call plugins#yarn#exec('test', 1, 0)<cr>
	nmap <leader><leader>c :call plugins#yarn#exec('typecheck', 1, 0)<cr>
	nmap <leader><leader>l :call plugins#yarn#exec('lint', 1, 0)<cr>
	nmap <leader><leader>f :call plugins#yarn#exec('format', 1, 0)<cr>

	" animate
	nmap <leader>j :call plugins#yarn#terminal()<cr>
	nmap <leader>d :call plugins#yarn#exec('dev', 0, 1)<cr>
	nmap <leader>s :call plugins#yarn#exec('ui-catalog', 0, 1)<cr>
	nmap <leader>t :call plugins#yarn#exec('test:unit:watch ' . expand('%:p:h'), 0, 1)<cr>
	nmap <leader>c :call plugins#yarn#exec('typecheck', 0, 1)<cr>
	nmap <leader>l :call plugins#yarn#exec('lint', 0, 1)<cr>
	nmap <leader>f :call plugins#yarn#exec('format', 0, 1)<cr>
endfunction

function! plugins#yarn#coffeebreak()
	call plugins#yarn#exec('test', 1, 0)
	call plugins#yarn#exec('lint', 1, 0)
	call plugins#yarn#exec('typecheck', 1, 0)
endfunction

function! plugins#yarn#exec(cmd, tab, animate)
	if a:tab
		exec ":tabnew"
	else
		new
	endif
	set nonumber
	exec ":terminal yarn " . a:cmd
	if a:animate
		call plugins#yarn#animate()
	endif
endfunction

function! plugins#yarn#terminal()
	new
	set nonumber
	exec ":terminal"
	call plugins#yarn#animate()
endfunction

function! plugins#yarn#animate()
	wincmd J | resize 1
	call animate#window_percent_height(0.20)
endfunction
