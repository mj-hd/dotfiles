function! hooks#lightline#init()
	let g:lightline = {
		\ 'colorscheme': 'jellybeans',
		\ 'mode_map': { 'c': 'NORMAL' },
		\ 'active': {
		\	 'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'vista' ] ],
		\	 'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'], ['ale'] ]
		\ },
		\ 'component_function': {
		\	 'modified': 'MyModified',
		\	 'readonly': 'MyReadonly',
		\	 'fugitive': 'MyFugitive',
		\	 'filename': 'MyFilename',
		\	 'vista': 'Vista',
		\	 'fileformat': 'MyFileformat',
		\	 'filetype': 'MyFiletype',
		\	 'fileencoding': 'MyFileencoding',
		\	 'mode': 'MyMode',
		\	 'ale': 'ALE'
		\ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '|' }
		\ }
	
	function! MyModified()
		return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	endfunction
	
	function! MyReadonly()
		return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
	endfunction
	
	function! MyFilename()
		return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
			\ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
			\	&ft == 'unite' ? unite#get_status_string() : 
			\	&ft == 'vimshell' ? vimshell#get_status_string() :
			\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
			\ ('' != MyModified() ? ' ' . MyModified() : '')
	endfunction
	
	function! MyFugitive()
		if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
			let _ = fugitive#head()
			return strlen(_) ? ' '._ : ''
		endif
		return ''
	endfunction
	
	function! MyFileformat()
		return winwidth(0) > 70 ?
			\ (&fileformat == 'unix' ? '' :
			\ &fileformat == 'dos' ? '' :
			\ &fileformat == 'mac' ? '' : &fileformat) : ''
	endfunction
	
	function! MyFiletype()
		return winwidth(0) > 70 ?
			\ (strlen(&filetype) ?
			\  (&filetype == 'go' ? '' :
			\   &filetype == 'typescript' ? '' :
			\   &filetype == 'typescript.jsx' ? 'TSX' :
			\   &filetype == 'javascript' ? '' :
			\   &filetype == 'vim' ? '' :
			\   &filetype == 'php' ? '' : &filetype) : '') : ''
	endfunction
	
	function! MyFileencoding()
		return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
	endfunction
	
	function! MyMode()
		return winwidth(0) > 60 ? lightline#mode() : ''
	endfunction
	
	function! ALE() abort
		let l:counts = ale#statusline#Count(bufnr(''))
		let l:all_errors = l:counts.error + l:counts.style_error
		let l:all_non_errors = l:counts.total - l:all_errors
		return l:counts.total == 0 ? ' ' : printf('ﮏ %d  %d', all_errors, all_non_errors)
	endfunction
	
	function! Vista() abort
		return get(b:, 'vista_nearest_method_or_function', '')
	endfunction
endfunction
