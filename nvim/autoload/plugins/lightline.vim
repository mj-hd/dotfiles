function! plugins#lightline#load() abort
	let g:scrollstatus_size = 10
	let g:scrollstatus_symbol_track = '▁'
	let g:scrollstatus_symbol_bar = '▃'

	let g:lightline = {
		\ 'colorscheme': 'kanagawa',
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
			\ 'right': [ [ 'filetype' ], [ 'percent' ], [ 'progress' ] ]
			\ },
			\ 'component_function': {
				\ 'filetype': 'plugins#lightline#filetype',
				\ 'percent': 'ScrollStatus',
				\ 'progress': 'plugins#lightline#progress'
			\ }
		\ }
endfunction

function! plugins#lightline#filetype()
	return WebDevIconsGetFileTypeSymbol()
endfunction

function! plugins#lightline#progress() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
	  return substitute(luaeval("require('lsp-status').status()"), '\[.\{-}\]', '', 'g')
  endif

  return ''
endfunction
