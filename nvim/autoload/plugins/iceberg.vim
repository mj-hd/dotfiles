function! plugins#iceberg#load() abort
	colorscheme iceberg
	au ColorScheme * hi! SpecialKey ctermfg=236 guifg=#242940
	au ColorScheme * hi! NonText ctermfg=236 guifg=#242940
	au ColorScheme * hi! EndOfBuffer ctermfg=236 guifg=#242940
endfunction
