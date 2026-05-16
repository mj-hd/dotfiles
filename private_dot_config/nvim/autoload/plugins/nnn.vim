function! plugins#nnn#load()
	let g:nnn#layout = { 'window': { 'width': 0.8, 'height': 0.4, 'highlight': 'Debug' } }
	let g:nnn#statusline = 0

	nnoremap <silent> <leader>w :NnnPicker '%:p:h'<cr>
endfunction
