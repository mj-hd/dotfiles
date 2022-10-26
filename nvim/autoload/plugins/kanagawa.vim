function! plugins#kanagawa#load() abort
lua << EOF
	require('kanagawa').setup({
		undercurl = true,
		commentStyle = {},
		functionStyle = {},
		keywordStyle = { bold = true },
		statementStyle = { bold = true },
		typeStyle = {},
		variablebuiltinStyle = { italic = true },
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
