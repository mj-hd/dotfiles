augroup lang
	autocmd!

	autocmd BufRead,BufNewFile *.dart call languages#dart#load()
	autocmd BufRead,BufNewFile *.tsx,*.ts,*.jsx,*.js call languages#js#load()
	autocmd BufRead,BufNewFile *.rs call languages#rust#load()
	autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
	autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil, 1000)
	autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup end
