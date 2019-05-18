function! hooks#startify#init()
	let g:startify_files_number = 5
	let g:startify_list_order = [
		\ ['		 ♻	最近使ったファイル:'],
		\ 'files',
		\ ['		 ♲	最近使ったファイル(カレントディレクトリ下):'],
		\ 'dir',
		\ ['		 ⚑	セッション:'],
		\ 'sessions',
		\ ['		 ☺	ブックマーク:'],
		\ 'bookmarks',
		\ ]
	let g:startify_bookmarks = ["~/.config/nvim/init.vim"]
	nnoremap <silent> ! :Startify<CR>
endfunction
