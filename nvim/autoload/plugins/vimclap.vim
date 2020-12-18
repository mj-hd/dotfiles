function! plugins#vimclap#filer() abort
	execute ':Clap filer ' . expand('%:p:h')
endfunction

function! plugins#vimclap#load() abort
	let g:clap_layout = { 'relative': 'editor' }
	
	let g:clap_current_selection_sign = {
		\ 'text': '',
		\ 'texthl': 'ClapCurrentSelection',
		\ 'linehl': 'ClapCurrentSelection',
		\ }
	
	let g:clap_selected_sign = {
		\ 'text': '',
		\ 'texthl': 'ClapSelected',
		\ 'linehl': 'ClapSelected',
		\ }
	
	let g:clap_popup_border = 'rounded'
	let g:clap_insert_mode_only = v:true
	let g:clap_providers_relaunch_code = '>'
	
	let g:clap_prompt_format = 'ﱢ %spinner% '
	let g:clap_spinner_frames = [ "◜", "◠", "◝", "◞", "◡", "◟" ]
	
	let g:clap_builtin_fuzzy_filter_threshold = 500
	let g:clap_on_move_delay = 16
	let g:clap_popup_input_delay = 16
	let g:clap_provider_grep_opts = "-H --no-heading --vimgrep --smart-case --no-ignore-dot"
	let g:clap_no_matches_msg = ' no matches'

	let g:clap_theme = 'nord'

	nnoremap <silent> <C-p> :Clap files +no-cache<cr>
	nnoremap <silent> <C-b> :Clap buffers<cr>
	nnoremap <silent> <C-f> :Clap grep2 +no-cache<cr>
	nnoremap <silent> <C-y> :Clap yanks<cr>
	nnoremap <silent> <space>. :Clap coc_actions<cr>
	nnoremap <silent> <space>p :Clap coc_commands<cr>
	nnoremap <silent> <space>[ :Clap coc_diagnostics<cr>
	nnoremap <silent> <space><space> :Clap coc_symbols<cr>
endfunction
