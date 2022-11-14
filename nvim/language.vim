augroup lang
	autocmd!

	autocmd BufRead,BufNewFile *.dart call languages#dart#load()
	autocmd BufRead,BufNewFile *.tsx,*.ts,*.jsx,*.js call languages#js#load()
	autocmd BufRead,BufNewFile *.rs call languages#rust#load()
	autocmd BufRead,BufNewFile *.vim call languages#vim#load()
	autocmd BufRead,BufNewFile *.go call languages#go#load()
	autocmd BufWritePre *.rs lua vim.lsp.buf.format()
	autocmd BufWritePre *.dart lua vim.lsp.buf.format()
	autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js lua vim.lsp.buf.format()
	autocmd BufWritePre *.vim lua vim.lsp.buf.format()
	autocmd BufWritePre *.lua lua vim.lsp.buf.format()
	autocmd BufWritePre *.go lua vim.lsp.buf.format()
augroup end
