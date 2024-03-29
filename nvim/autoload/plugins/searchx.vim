function! plugins#searchx#load()
	" Overwrite / and ?.
	nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
	nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
	xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
	xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
	
	" Move to next/prev match.
	nnoremap N <Cmd>call searchx#prev_dir()<CR>
	nnoremap n <Cmd>call searchx#next_dir()<CR>
	xnoremap N <Cmd>call searchx#prev_dir()<CR>
	xnoremap n <Cmd>call searchx#next_dir()<CR>
	nnoremap <C-,> <Cmd>call searchx#prev()<CR>
	nnoremap <C-m> <Cmd>call searchx#next()<CR>
	xnoremap <C-,> <Cmd>call searchx#prev()<CR>
	xnoremap <C-m> <Cmd>call searchx#next()<CR>
	" cnoremap <C-i> <Cmd>call searchx#prev()<CR>
	" cnoremap <C-m> <Cmd>call searchx#next()<CR>
	
	" Clear highlights
	nnoremap <C-y> <Cmd>call searchx#clear()<CR>
	
	let g:searchx = {}
	
	" Auto jump if the recent input matches to any marker.
	let g:searchx.auto_accept = v:true
	
	" The scrolloff value for moving to next/prev.
	let g:searchx.scrolloff = &scrolloff
	
	" Marker characters.
	let g:searchx.markers = split('HJGFYUTRNMBV', '.\zs')
	
	" Convert search pattern.
	function g:searchx.convert(input) abort
	  if a:input !~# '\k'
	    return '\V' .. a:input
	  endif
	  return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
	endfunction
endfunction
