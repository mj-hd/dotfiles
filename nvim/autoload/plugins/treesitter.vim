function! plugins#treesitter#load()
lua <<EOF
	require'nvim-treesitter.install'.compilers = { "gcc-11" }
	require'nvim-treesitter.configs'.setup {
		ensure_installed = "maintained",
		highlight = {
			enable = true,
			disable = {},
		},
	}
EOF
endfunction
