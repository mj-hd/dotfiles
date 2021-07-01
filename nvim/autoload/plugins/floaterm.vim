function! plugins#floaterm#load() abort
	let g:floaterm_width = 0.8
	let g:floaterm_height = 0.6
	let g:floaterm_winblend = 10
	let g:floaterm_position = 'center'

	let g:floaterm_keymap_new    = 'tk'
	let g:floaterm_keymap_prev   = 'th'
	let g:floaterm_keymap_next   = 'tl'
	let g:floaterm_keymap_toggle = 'tt'

	autocmd FileType floaterm call plugins#floaterm#settings()

	nnoremap <silent> <leader>e :FloatermNew nnn '%:p:h'<cr>
	nnoremap <silent> <leader>g :FloatermNew lazygit<cr>
endfunction

function! plugins#floaterm#settings() abort
	tnoremap <buffer> <silent> <ESC> <C-\><C-n>:FloatermToggle<cr>
	nnoremap <buffer> <silent> <ESC> :FloatermToggle<cr>
endfunction
