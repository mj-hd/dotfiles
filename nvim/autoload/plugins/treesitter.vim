function! plugins#treesitter#load()
lua <<EOF
	-- require'nvim-treesitter.install'.compilers = { "gcc-10" }
	require'nvim-treesitter.configs'.setup {
		ensure_installed = "all",
		highlight = {
			enable = true,
			disable = {},
		},
	}
EOF
endfunction
