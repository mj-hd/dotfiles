function! hooks#fruzzy#init()
	let g:fruzzy#usenative = 1

	call denite#custom#source('_', 'matchers', ['matcher/fruzzy', 'matcher/ignore_globs'])
endfunction
