function! hooks#vista#init()
	let g:vista_sidebar_position = 'vertical botright'
	let g:vista_sidebar_width = 30
	let g:vista_echo_cursor = 1
	let g:vista_cursor_delay = 400
	let g:vista_close_on_jump = 0
	let g:vista_stay_on_open = 1
	let g:vista_blink = [2, 100]
	let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
	let g:vista_default_executive = 'ctags'
	let g:vista_ctags_cmd = {
		\ 'haskell': 'hasktags -o - -c',
		\ 'go': 'gotags -sort -silent',
		\ }
	let g:vista_fzf_preview = ['right:50%']
endfunction
