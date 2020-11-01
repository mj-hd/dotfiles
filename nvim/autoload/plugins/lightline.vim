function! plugins#lightline#load() abort
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
			\ 'right': [[ 'filetype' ]]
			\ },
			\ 'component_function': {
				\ 'filetype': 'plugins#lightline#filetype',
			\ }
		\ }
endfunction

function! plugins#lightline#filetype()
	return WebDevIconsGetFileTypeSymbol()
endfunction
