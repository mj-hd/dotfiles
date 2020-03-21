let s:commands = {}

function! s:commands.source() abort
	try
		return map(CocAction('commands'),
			\ { _, command -> command['id'] . ': ' . command['title']})
	catch
		return []
	endtry
endfunction

function! s:commands.sink(selected) abort
	let l:command = split(a:selected, ':')[0]
	call CocActionAsync('runCommand', l:command)
endfunction

let s:code_actions = {}

function! s:code_actions.source() abort
	let l:orig_buf = bufnr()
	execute 'b' g:clap.start.bufnr

	try
		let s:code_actions.candidates = map(CocAction('codeActions'),
			\ { _, action -> 
				\ { 'id': action['clientId'] . ': ' . action['title'], 'action': action } })
		execute 'b ' . l:orig_buf
		return map(copy(s:code_actions.candidates), { _, candidate -> candidate['id'] })
	catch
		return []
	endtry
endfunction

function! s:code_actions.sink(selected) abort
	let l:action = filter(copy(s:code_actions.candidates),
		\ { _, candidate -> candidate['id'] == a:selected })
	call CocActionAsync('doCodeAction', l:action[0]['action'])
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

	let g:clap_theme = {
		\ 'current_selection': { 'ctermbg': '236', 'guibg': '#3d425b' },
		\ }

	let g:clap_fuzzy_match_hl_groups = [[ 255, '#eff0f4' ]]

	let g:clap_provider_code_action = s:code_actions
	let g:clap_provider_commands = s:commands

	nnoremap <silent> <C-p> :Clap files<cr>
	nnoremap <silent> <C-b> :Clap buffers<cr>
	nnoremap <silent> <C-f> :Clap grep<cr>
	nnoremap <silent> <C-y> :Clap yanks<cr>
	nnoremap <silent> <space>. :Clap code_action<cr>
	nnoremap <silent> <space>p :Clap commands<cr>
endfunction
