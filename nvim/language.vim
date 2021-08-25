augroup lang
	autocmd!

	autocmd BufRead,BufNewFile *.dart call languages#dart#load()
	autocmd BufRead,BufNewFile *.tsx,*.ts,*.jsx,*.js call languages#js#load()
augroup end
