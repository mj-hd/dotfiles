function! hooks#molokai#init()
	set background=dark
	let g:rehash256 = 1
	let g:molokai_original = 1
	au MyAutoCmd VimEnter * nested colorscheme molokai
	colorscheme molokai
endfunction
