function! hooks#theme#init()
	let g:material_style='oceanic'
	set background=dark
	au MyAutoCmd VimEnter * nested colorscheme vim-material
	colorscheme vim-material
	let g:airline_theme = 'material'
endfunction
