function! plugins#expandregion#load()
	vnoremap <silent> J <Plug>(expand_region_expand)
	vnoremap <silent> K <Plug>(expand_region_shrink)
endfunction
