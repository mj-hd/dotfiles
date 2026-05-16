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

	local mason = require("mason")

	mason.setup({})

	local on_attach = function(client, bufnr)
		local opts = { noremap=true, silent=true }

		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', ',r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-,>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-m>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

		lsp_status.on_attach(client)
	end

	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_initialized = {
			"rust-analyzer",
			"lua_ls",
			"gopls",
			"yamlls",
			"dockerfile-language-server",
			"clangd",
			"vim-language-server",
			"golangci-lint-langserver",
			"bash-language-server",
			"ts_ls",
			"biome",
			"json-lsp",
			"efm"
		},
	})

	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
	capabilities.offsetEncoding = { "utf-16" }

	vim.lsp.config('*', {
		on_attach = on_attach,
		capabilities = capabilities,
	})

	vim.lsp.config('lua_ls', {
		filetypes = { "lua" },
		settings = {
			Lua = {
				runtime = { version = 'LuaJIT' },
				diagnostics = { globals = {'vim'} },
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				telemetry = { enable = false },
			},
		},
	})

	vim.lsp.config('gopls', {
		filetypes = { "go", "gomod" },
		root_markers = { "go.mod", ".git" },
		settings = {
			codelenses = { generate = true, gc_details = true },
		},
	})

	vim.lsp.config('golangci_lint_ls', {
		filetypes = { "go", "gomod" },
		root_markers = { 'go.mod', '.golangci.yaml', '.git' },
	})

	vim.lsp.config('efm', {
		init_options = { documentFormatting = true },
	})

	vim.lsp.enable({
		'rust_analyzer',
		'lua_ls',
		'gopls',
		'golangci_lint_ls',
		'clangd',
		'ts_ls',
		'vimls',
		'bashls',
		'biome',
		'jsonls',
		'efm',
	})

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

	vim.diagnostic.config({
		virtual_text = {
			prefix = '✔︎',
		},
		signs = false,
		underline = false,
	})
EOF

endfunction
