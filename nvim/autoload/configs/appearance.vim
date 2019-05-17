function! configs#appearance#init()
	syntax on
	
	" タブ
	set ts=4 sw=4
	set softtabstop=4
	set noexpandtab
	
	set notitle
	set showmatch
	set showcmd
	set wrap
	set number
	set ruler
	set cmdheight=2
	set list
	set listchars=tab:»_,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
	set laststatus=2
	set wildmenu
	set wildmode=full:list
	
	set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
	
	set showtabline=2
endfunction
