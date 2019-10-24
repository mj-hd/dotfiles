function! hooks#yarn#init()
	nmap <space>d :call hooks#yarn#dev()<cr>
	nmap <space>s :call hooks#yarn#storybook()<cr>
	nmap <space>t :call hooks#yarn#test()<cr>
	nmap <space>c :call hooks#yarn#typecheck()<cr>
	nmap <space>l :call hooks#yarn#lint()<cr>
	nmap <space>f :call hooks#yarn#format()<cr>
endfunction

function! hooks#yarn#dev()
	exec ":tabnew"
	exec ":terminal yarn dev"
endfunction

function! hooks#yarn#storybook()
	exec ":tabnew"
	exec ":terminal yarn ui-catalog"
endfunction

function! hooks#yarn#test()
	exec ":tabnew"
  exec ":terminal yarn test:unit:watch"
endfunction

function! hooks#yarn#lint()
	exec ":tabnew"
	exec ":terminal yarn lint"
endfunction

function! hooks#yarn#format()
	exec ":tabnew"
	exec ":terminal yarn format"
endfunction

function! hooks#yarn#typecheck()
	exec ":tabnew"
	exec ":terminal yarn typecheck"
endfunction
