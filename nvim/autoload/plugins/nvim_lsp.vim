function! plugins#nvim_lsp#load()
lua << EOF
	local lsp_status = require('lsp-status')

	lsp_status.config({
		current_function = false,
		show_filename = false,
		select_symbol = function(cursor_pos, document_symbol)
			return false
		end,
		spinner_frames = {'', '', '', '', ''},
		indicator_errors = '',
		indicator_warnings = '',
		indicator_info = '',
		indicator_hint = '',
		indicator_ok = '',
		update_interval = 100,
	})

	lsp_status.register_progress()

	local lsp_installer = require("nvim-lsp-installer")

	lsp_installer.settings({})
	
	lsp_installer.on_server_ready(function(server)
	    local opts = {}

		-- vim.lsp.set_log_level(0)

		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

			local opts = { noremap=true, silent=true }
			
			buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
			buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
			buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
			buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
			buf_set_keymap('n', ',r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
			buf_set_keymap('n', '<C-,>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
			buf_set_keymap('n', '<C-m>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
			buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

			lsp_status.on_attach(client)
		end

		local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
		capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

		opts.capabilities = capabilities
		opts.on_attach = on_attach

		require("flutter-tools").setup {
			ui = {
				border = "none",
			},
			decorations = {
				statusline = {
					app_version = false,
					device = false,
				}
			},
			debugger = {
				enabled = false,
				run_via_dap = false,
			},
			fvm = true,
			widget_guides = {
				enabled = true,
			},
			closing_tags = {
				highlight = "ClosingTags",
				prefix = " ",
				enabled = true
			},
			dev_log = {
				enabled = true,
				open_cmd = "tabedit",
			},
			dev_tools = {
				autostart = false,
				auto_open_browser = false,
			},
			outline = {
				open_cmd = "30vnew",
				auto_open = false
			},
			lsp = {
				on_attach = function(client, bufnr)
					vim.cmd [[hi FlutterWidgetGuides ctermfg=237 guifg=#33374c]]
					vim.cmd [[hi ClosingTags ctermfg=244 guifg=#8389a3]]
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
				settings = {
					showTodos = false,
					completeFunctionCalls = true,
					analysisExcludedFolders = {
						vim.fn.expand("$HOME/.pub-cache"),
						vim.fn.expand("$HOME/fvm"),
					}
				}
			}
		}
	
	    server:setup(opts)
	end)

	vim.diagnostic.config({
		virtual_text = {
			prefix = '✔︎',
		},
		signs = false,
		underline = false,
	})
EOF

endfunction
