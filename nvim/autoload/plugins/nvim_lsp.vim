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
		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		local opts = { noremap=true, silent=true }

		buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		buf_set_keymap('n', ',r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', '<C-,>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
		buf_set_keymap('n', '<C-m>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

		lsp_status.on_attach(client)
	end

	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_initialized = {
			"rust-analyzer",
			"sumneko_lua",
			"gopls",
			"typescript-language-server",
			"yamlls",
			"dockerfile-language-server",
			"clangd",
			"tsserver",
			"vim-language-server",
			"golangci-lint-langserver",
			"bash-language-server",
			"stylelint-lsp",
			"json-lsp",
			"efm"
		},
	})

	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
	capabilities.offsetEncoding = { "utf-16" }

	local util = require("lspconfig/util")

	require("lspconfig").rust_analyzer.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").sumneko_lua.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "lua" },
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = {'vim'},
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	}
	require("lspconfig").gopls.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "go", "gomod" },
		root_dir = util.root_pattern("go.mod", ".git"),
		settings = {
			codelenses = {
				generate = true,
				gc_details = true
			}
		}
	}
	require("lspconfig").golangci_lint_ls.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "go", "gomod" },
		root_dir = util.root_pattern('go.mod', '.golangci.yaml', '.git')
	}
	require("lspconfig").tsserver.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").yamlls.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			yaml = {
				trace = {
					server = "verbose"
				},
				schemaStore = {
					url = "https://json.schemastore.org/"
				},
				schemas = {
					["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
					kubernetes = "/*manifest*/**/*.yaml"
				}
			}
		},
	}
	require("lspconfig").dockerls.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").clangd.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").tsserver.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").vimls.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").bashls.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").stylelint_lsp.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").jsonls.setup { on_attach = on_attach, capabilities = capabilities }
	require("lspconfig").efm.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		init_options = {
			documentFormatting = true
		},
	}

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
