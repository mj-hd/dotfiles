function! plugins#telescope#load()
	nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
	nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
	nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
	nnoremap <leader>e <cmd>lua require('telescope').extensions.file_browser.file_browser({initial_mode='normal', preview=false, path = vim.fn.expand('%:p:h')})<cr>
	nnoremap <leader>. <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
	vnoremap <leader>/ <cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>
	nnoremap <leader>c <cmd>lua require('telescope.builtin').git_bcommits()<cr>
	nnoremap <leader>b <cmd>lua require('telescope.builtin').git_branches()<cr>
	nnoremap <leader>s <cmd>lua require('telescope.builtin').git_status()<cr>
	nnoremap <leader>f <cmd>lua require('telescope.builtin').quickfix()<cr>
	nnoremap <leader><leader> <cmd>lua require('telescope.builtin').builtin()<cr>
	inoremap <C-v> <cmd>lua require('telescope.builtin').registers()<cr>

lua << EOF
	local actions = require('telescope.actions')
	local actions_set = require('telescope.actions.set')
	local themes = require('telescope.themes')

	local telescope = require('telescope')
	local fb_actions = require('telescope._extensions.file_browser.actions')

	telescope.setup{
		defaults = {
			layout = 'horizontal',
			winblend = 10,
			prompt_prefix = 'ﱢ ',
			selection_caret = ' ',
			entry_prefix = '  ',
			initial_mode = 'insert',
			border = false,
			sorting_strategy = 'ascending',
			mappings = {
				i = {
					['<esc>'] = actions.close,
					['<C-h>'] = 'which_key',
					['<C-Down>'] = actions.cycle_history_next,
					['<C-Up>'] = actions.cycle_history_prev,
					['<C-j>'] = actions.cycle_history_next,
					['<C-k>'] = actions.cycle_history_prev
				}
			},
			layout_config = {
				horizontal = {
					height = 0.7,
					preview_cutoff = 120,
					preview_width = 50,
					prompt_position = 'top',
					width = 0.7,
				},
				cursor = {
					height = 0.2,
					preview_cutoff = 40,
					width = 0.6
				}
			}
		},
		pickers = {
			registers = {
				theme = 'cursor'
			},
			lsp_code_actions = {
				theme = 'cursor'
			}
		},
		extensions = {
			file_browser = {
				mappings = {
					["i"] = {
						["<C-d>"] = fb_actions.remove_file,
						["<C-n>"] = fb_actions.create_file,
						["<C-h>"] = fb_actions.goto_parent_dir,
						["<C-.>"] = fb_actions.toggle_hidden,
						["<C-o>"] = fb_actions.open_file,
						["<C-r>"] = fb_actions.rename_file,
						["<C-y>"] = fb_actions.copy_file,
						["<C-q>"] = actions.close,
					},
					["n"] = {
						["dd"] = fb_actions.remove_file,
						["n"] = fb_actions.create_file,
						["h"] = fb_actions.goto_parent_dir,
						["<left>"] = fb_actions.goto_parent_dir,
						["l"] = actions_set.select,
						["<right>"] = actions_set.select,
						["g."] = fb_actions.toggle_hidden,
						["m"] = fb_actions.move_file,
						["o"] = fb_actions.open_file,
						["r"] = fb_actions.rename_file,
						["y"] = fb_actions.copy_file,
						["q"] = actions.close,
					},
				},
			}
		}
	}

	telescope.load_extension "file_browser"
EOF
endfunction
