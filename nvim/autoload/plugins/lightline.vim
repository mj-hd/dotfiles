function! plugins#lightline#load() abort
	let g:scrollstatus_size = 15
	let g:scrollstatus_symbol_track = '▁'
	let g:scrollstatus_symbol_bar = '▃'

	let g:lightline = {
		\ 'colorscheme': 'iceberg',
		\ 'mode_map': {
			\ 'n' : ' ',
			\ 'i' : '﫦',
			\ 'v' : '濾',
			\ 'V': ' ',
			\ "\<C-v>" : '礪',
			\ 't': ' ',
		\ },
		\ 'active': {
			\ 'left': [ [ 'mode', 'paste' ],
				\ [ 'readonly', 'filename', 'modified' ] ],
			\ 'right': [ [ 'filetype' ], [ 'percent' ] ]
			\ },
			\ 'component_function': {
				\ 'filetype': 'plugins#lightline#filetype',
				\ 'percent': 'ScrollStatus'
			\ }
		\ }
endfunction

function! plugins#lightline#filetype()
	return WebDevIconsGetFileTypeSymbol()
endfunction
