function! hooks#ale#init()
	let g:ale_lint_on_enter = 1
	let g:ale_fix_on_save = 0
	let g:ale_completion_enabled = 0
	let g:ale_sign_error = "➔"
	let g:ale_sign_warning = "➢"
	let g:ale_set_loclist = 0
	hi ALEWarningSign ctermfg=Yellow
	hi ALEErrorSign ctermfg=Red
endfunction
