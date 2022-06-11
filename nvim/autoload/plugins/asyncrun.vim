function! plugins#asyncrun#load()
	autocmd User AsyncRunStart call plugins#asyncrun#on_start()
	autocmd User AsyncRunStop call plugins#asyncrun#on_exit()
endfunction

function! plugins#asyncrun#on_start()
	lua vim.notify("Command '" .. vim.g["task_name"] .. "' started", "info")
endfunction

function! plugins#asyncrun#on_exit()
	if g:asyncrun_status == "running"
		return
	endif

	if g:asyncrun_status == "success"
		lua vim.notify("succeeded", "info", {
			title = "Command '" .. vim.g["task_name"] .. "'"
			on_open = function(win)
				local buf = vim.api.nvim_win_get_buf(win)

			end,
		})
	elseif g:asyncrun_status == "failure"
		lua vim.notify("Command '" .. vim.g["task_name"] .. "' failed with exit code " .. vim.g["asyncrun_code"], "error")
	endif
endfunction
