function! plugins#vfiler#load()
	nnoremap <leader>e <cmd>lua require('vfiler').start(vim.fn.expand('%:p:h'), require('vfiler/config').around)<cr>
	nnoremap <leader>w <cmd>lua require('vfiler').start('', require('vfiler/config').filer)<cr>

lua << EOF
	local action = require('vfiler/action')
	local config = require('vfiler/config')

	config.around = {
		options = {
			auto_resize = true,
			header = true,
			name = 'around',
			blend = 20,
			layout = 'floating',
			border = 'shadow',
			columns = 'indent,devicons,name',
			keep = true,
		},
		mappings = {
			['<esc>'] = action.quit,
			['<C-s>'] = action.open_by_split,
			['s'] = action.toggle_sort,
		},
	}

	config.filer = {
		options = {
			header = true,
			name = 'filer',
			layout = 'tab',
			columns = 'indent,devicons,name,mode,size,time',
			['git.ignored'] = false,
			['git.untracked'] = false,
		},
		mappings = {
			['h'] = action.switch_to_filer,
			['l'] = action.switch_to_filer,
			['<left>'] = action.switch_to_filer,
			['<right>'] = action.switch_to_filer,
		},
	}
EOF
endfunction
