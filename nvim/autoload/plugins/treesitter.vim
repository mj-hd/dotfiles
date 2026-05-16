function! plugins#treesitter#load()
lua <<EOF
	-- require'nvim-treesitter.install'.compilers = { "gcc-10" }
	require'nvim-treesitter.configs'.setup {
		ensure_installed = {
			"lua", "vim", "vimdoc", "query",
			"rust", "go", "gomod", "gowork",
			"typescript", "javascript", "tsx",
			"dart",
			"bash",
			"json", "yaml", "toml",
			"markdown", "markdown_inline",
			"c", "cpp",
			"python",
			"dockerfile",
		},
		auto_install = true,
		highlight = {
			enable = true,
			disable = {},
		},
	}
EOF
endfunction
