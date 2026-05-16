function! plugins#skylight#load()
	let g:skylight_position = 'auto'
	let g:skylight_width = 0.8
	let g:skylight_height = 0.3

	nmap <silent> gp :SkylightPreview<cr>
	nmap <silent><expr> <C-j> skylight#float#has_scroll() ? skylight#float#scroll(1) : '' 
	nmap <silent><expr> <C-k> skylight#float#has_scroll() ? skylight#float#scroll(0) : '' 
endfunction
