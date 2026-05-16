function! plugins#modes#load() abort
lua << EOF
	require('modes').setup({
		colors = {
			copy = "#DCA561",
			delete = "#C34043",
			insert = "#98BB6C",
			visual = "#FFA066",
		},
		line_opacity = 0.2,
		set_cursor = false,
		-- focus_only = true
	})
EOF
endfunction
