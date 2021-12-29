function! plugins#nvim_lsp#load()
lua << EOF
	local lsp_installer = require("nvim-lsp-installer")

	lsp_installer.settings({})
	
	lsp_installer.on_server_ready(function(server)
	    local opts = {}

		local on_attach = function(client, bufnr)
		  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
		
		  local opts = { noremap=true, silent=true }
		
		  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		  buf_set_keymap('n', ',r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
		  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
		end

		local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

		opts.capabilities = capabilities
		opts.on_attach = on_attach
	
	    server:setup(opts)
	end)

	vim.diagnostic.config({
		virtual_text = {
			prefix = '✔︎',
		},
		signs = false,
	})
EOF
endfunction
