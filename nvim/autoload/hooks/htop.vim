function! hooks#htop#init()
	nmap <space>h :call hooks#htop#open()<cr>
endfunction

function! hooks#htop#open()
	let buf = nvim_create_buf(v:false, v:false)
	let height = &lines
	let width = &columns
	let opts = {
				\ 'relative': 'editor',
				\ 'width': width, 'height': height,
				\ 'col': 0, 'row': 0,
				\ }
	let win = nvim_open_win(buf, v:true, opts)
	call nvim_win_set_option(win, "winblend", 30)
	setlocal
		\ buftype=nofile
		\ nobuflisted
		\ bufhidden=hide
		\ nonumber
		\ norelativenumber
		\ signcolumn=no
	exec ":terminal htop"
endfunction

