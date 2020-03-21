function! plugins#lightline#load() abort
	let g:lightline = {
		\ 'colorscheme': 'iceberg',
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
