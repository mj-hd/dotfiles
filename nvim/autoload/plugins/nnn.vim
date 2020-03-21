function! plugins#nnn#load()
	let g:nnn#layout = { 'window': { 'width': 0.8, 'height': 0.4, 'highlight': 'Debug' } }

	nnoremap <silent> <space>e :NnnPicker '%:p:h'<cr>
endfunction
