function! plugins#telescope#load()
	nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
	nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
	nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
	nnoremap <leader>. <cmd>lua vim.lsp.buf.code_action()<cr>
	vnoremap <leader>/ <cmd>lua vim.lsp.buf.range_code_action()<cr>
	nnoremap <leader>c <cmd>lua require('telescope.builtin').git_bcommits()<cr>
	nnoremap <leader>b <cmd>lua require('telescope.builtin').git_branches()<cr>
	nnoremap <leader>s <cmd>lua require('telescope.builtin').git_status()<cr>
	nnoremap <leader>f <cmd>lua require('telescope.builtin').quickfix()<cr>
	nnoremap <leader>n <cmd>lua require('telescope').extensions.notify.notify()<cr>
	nnoremap <leader><leader> <cmd>lua require('telescope.builtin').builtin()<cr>
	inoremap <C-v> <cmd>lua require('telescope.builtin').registers()<cr>

	hi link TelescopePromptCounter Comment

lua << EOF
	local actions = require('telescope.actions')
	local actions_set = require('telescope.actions.set')
	local themes = require('telescope.themes')

	local telescope = require('telescope')

	telescope.setup{
		defaults = {
			layout = 'horizontal',
			winblend = 20,
			prompt_prefix = 'ﱢ ',
			selection_caret = ' ',
			entry_prefix = '  ',
			initial_mode = 'insert',
			border = false,
			sorting_strategy = 'ascending',
			path_display = { 'truncate' },
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
			["ui-select"] = {}
		}
	}

	telescope.load_extension "flutter"
	telescope.load_extension "ui-select"
EOF
endfunction
