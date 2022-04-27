function! plugins#kanagawa#load() abort
lua << EOF
	require('kanagawa').setup({
		undercurl = true,
		commentStyle = "NONE",
		functionStyle = "NONE",
		keywordStyle = "bold",
		statementStyle = "bold",
		typeStyle = "NONE",
		variablebuiltinStyle = "italic",
		specialReturn = true,
		specialException = true,
		transparent = false,
		dimInactive = false,
		colors = {},
		overrides = {},
	})

	vim.cmd("colorscheme kanagawa")
EOF
endfunction
