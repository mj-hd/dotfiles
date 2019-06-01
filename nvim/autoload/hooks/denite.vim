function! hooks#denite#init()
	call denite#custom#option('_', {
		\ 'prompt': '»',
		\ 'auto_resize': v:true,
		\ 'auto_resume': v:true,
		\ 'split': 'floating',
		\ 'direction': 'rightbelow',
		\ 'matchers': 'matcher/fruzzy',
		\ 'winwidth': &columns * 4 / 5,
		\ 'wincol': (&columns - (&columns * 4 / 5)) / 2,
		\ 'winheight': &lines * 3 / 5 ,
		\ 'winrow': (&lines - (&lines * 3 / 5)) / 2,
		\ })

	call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [
		\ '.git/', '.ropeproject/', '__pycache__/',
		\ 'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
		\ 'node_modules/', 'vendor/', '.cache/', '*.log',
		\ ])

	call denite#custom#source('grep', 'args', ['', '', '!'])
	" 検索結果がチラつくバグがあるっぽいので一時的に無効に
	" call denite#custom#source('file/rec', 'converters', ['devicons_denite_converter'])

	let s:menus = {}
	let s:menus.dotfiles = { 'description': 'configration files' }
	let s:menus.dotfiles.file_candidates = [
		\ ['vimrc', '~/.config/nvim/init.vim'],
		\ ['zshrc', '~/.zshrc'],
		\ ['env', '~/.env'],
		\ ['env', '~/.env'],
		\ ['ranger_rc', '~/.config/ranger/rc.conf'],
		\ ['ranger_commands', '~/.config/ranger/commands.py'],
		\ ['ranger_rifle', '~/.config/ranger/rifle.conf'],
		\ ['ranger_scope', '~/.config/ranger/scope.sh'],
		\ ['ranger_commands_full', '~/.config/ranger/commands_full.py'],
		\ ]

	call denite#custom#var('menu', 'menus', s:menus)

	if executable("ag")
		call denite#custom#var('file/rec', 'command',
			\ ['ag', '--follow', '--nogroup', '-g', ''])

		call denite#custom#var('grep', 'command', ['ag'])
		call denite#custom#var('grep', 'default_opts',
				\ ['-i', '--vimgrep'])
		call denite#custom#var('grep', 'recursive_opts', [])
		call denite#custom#var('grep', 'pattern_opt', [])
		call denite#custom#var('grep', 'separator', ['--'])
		call denite#custom#var('grep', 'final_opts', [])
	endif
endfunction

function! hooks#denite#keymaps()
	autocmd FileType denite call s:denite()
	autocmd FileType denite-filter call s:filter()

	nnoremap <C-p> :DeniteProjectDir file/rec<CR>
	nnoremap <C-f> :DeniteProjectDir grep<CR>
	nnoremap <C-b> :DeniteProjectDir buffer<CR>
	nnoremap <C-m> :DeniteProjectDir menu<CR>
endfunction

function! s:denite() abort
	nnoremap <silent><buffer><expr> <CR>
		\ denite#do_map('do_action')
	nnoremap <silent><buffer><expr> <ESC>
		\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> i
		\ denite#do_map('open_filter_buffer')
endfunction

function! s:filter() abort
	nnoremap <silent><buffer><expr> <ESC>
		\ denite#do_map('quit')
endfunction
