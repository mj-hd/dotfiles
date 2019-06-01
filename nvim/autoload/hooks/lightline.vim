function! hooks#lightline#init()
	let g:lightline = {
		\ 'colorscheme': 'jellybeans',
		\ 'mode_map': { 'c': 'NORMAL' },
		\ 'active': {
		\	 'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'vista' ] ],
		\	 'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'], ['ale'] ]
		\ },
		\ 'component_function': {
		\	 'modified': 'hooks#lightline#modified',
		\	 'readonly': 'hooks#lightline#readonly',
		\	 'fugitive': 'hooks#lightline#fugitive',
		\	 'filename': 'hooks#lightline#filename',
		\	 'vista': 'NearestMethodOrFunction',
		\	 'fileformat': 'hooks#lightline#fileformat',
		\	 'filetype': 'hooks#lightline#filetype',
		\	 'fileencoding': 'hooks#lightline#fileencoding',
		\	 'mode': 'MyMode',
		\	 'ale': 'ALE'
		\ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '|' }
		\ }
endfunction

function! hooks#lightline#modified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! hooks#lightline#readonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! hooks#lightline#filename()
	return ('' != hooks#lightline#readonly() ? hooks#lightline#readonly() . ' ' : '') .
		\ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
		\	&ft == 'unite' ? unite#get_status_string() : 
		\	&ft == 'vimshell' ? vimshell#get_status_string() :
		\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
		\ ('' != hooks#lightline#modified() ? ' ' . hooks#lightline#modified() : '')
endfunction

function! hooks#lightline#fugitive()
	if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
		let _ = fugitive#head()
		return strlen(_) ? ' '._ : ''
	endif
	return ''
endfunction

function! hooks#lightline#fileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! hooks#lightline#filetype()
	return winwidth(0) > 70 ?
		\ (strlen(&filetype) ?
		\ &filetype . ' ' . WebDevIconsGetFileTypeSymbol() :
		\ 'no ft') : ''
endfunction

function! hooks#lightline#fileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! hooks#lightline#mode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! hooks#lightline#ale() abort
	let l:counts = ale#statusline#Count(bufnr(''))
	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors
	return l:counts.total == 0 ? ' ' : printf('ﮏ %d  %d', all_errors, all_non_errors)
endfunction
