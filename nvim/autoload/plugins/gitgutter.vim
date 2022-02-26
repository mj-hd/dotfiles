function! plugins#gitgutter#init()
	let g:gitgutter_map_keys = 0
endfunction

function! plugins#gitgutter#load()
	let g:gitgutter_sign_added = '▐'
	let g:gitgutter_sign_modified = '▐'
	let g:gitgutter_sign_removed = '▐'
	let g:gitgutter_sign_removed_first_line = '▗'
	let g:gitgutter_sign_removed_above_and_below = '▝'
	let g:gitgutter_sign_modified_removed = '█'
endfunction
