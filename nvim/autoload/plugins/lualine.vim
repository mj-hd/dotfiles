function! plugins#lualine#load() abort
	let g:scrollstatus_size = 10
	let g:scrollstatus_symbol_track = '▁'
	let g:scrollstatus_symbol_bar = '▃'

lua << EOF
	local function filetype()
		return vim.call('WebDevIconsGetFileTypeSymbol')
	end

	local function status()
		local result = ''

		if #vim.lsp.buf_get_clients() > 0 then
  		    result = result .. require('lsp-status').status()
		end

		if vim.g["notify_command_status"] == "running" then
			result = result .. ' 喇'
		end

  		return result
	end

	local function mode()
		local m = vim.call('mode')
		local map = {
			n = ' ',
			i = '﫦',
			v = '濾',
			V = ' ',
			['<C-v>'] = '礪',
			t = ' ',
		}

		if map[m] == nil then
			return ''
		else
			return map[m]
		end
	end

	local colors = require('kanagawa.colors')

	require('lualine').setup {
		options = {
			icons_enabled = true,
			theme = 'kanagawa',
			component_separators = '',
			section_separators = '',
			disabled_filetypes = {},
			always_divide_middle = true,
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {status},
			lualine_y = {{'ScrollStatus', color = { fg = '#DCD7BA' }}, filetype},
			lualine_z = {}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {{'filename', symbols = { unnamed = '' }}},
			lualine_x = {},
			lualine_y = {filetype},
			lualine_z = {}
		},
		tabline = {
			lualine_a = {{'tabs', mode = 1}},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {'diff'},
			lualine_y = {'branch'},
			lualine_z = {}
		},
		extensions = {}
	}
EOF
endfunction
