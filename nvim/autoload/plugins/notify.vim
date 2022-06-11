function! plugins#notify#load()
lua << EOF
	local notify = require("notify")
	local stages_util = require("notify.stages.util")

	local custom_stages = {
		function(state)
			local next_height = state.message.height + 2
			local next_row = stages_util.available_slot(
				state.open_windows,
				next_height,
				stages_util.DIRECTION.BOTTOM_UP
			)
			if not next_row then
				return nil
			end
			return {
				relative = "editor",
				anchor = "NE",
				width = state.message.width,
				height = state.message.height,
				col = vim.opt.columns:get(),
				row = next_row,
				border = "none",
				style = "minimal",
				opacity = 50,
			}
		end,
		function()
			return {
				opacity = { 100 },
				col = { vim.opt.columns:get() },
			}
		end,
		function()
			return {
				col = { vim.opt.columns:get() },
				time = true,
			}
		end,
		function()
			return {
				width = {
					1,
					frequency = 2.5,
					damping = 0.9,
					complete = function(cur_width)
						return cur_width < 3
					end,
				},
				opacity = {
					0,
					frequency = 2,
					complete = function(cur_opacity)
						return cur_opacity <= 4
					end,
				},
				col = { vim.opt.columns:get() },
			}
		end,
	}

	notify.setup({
		render = "default",
		stages = custom_stages,
		timeout = 5000,
		max_width = 80,
		minimum_width = 50,
	})
	vim.notify = notify
EOF
endfunction

function! plugins#notify#command(command, opts)
	let g:_notify_command_arg_command = a:command
	let g:_notify_command_arg_opts = a:opts
	let g:notify_command_status = "running"
lua << EOF
	local command = vim.g["_notify_command_arg_command"]
	local opts = vim.g["_notify_command_arg_opts"]
	local output = ""
	local notification
	local notify = function(msg, level)
		local notify_opts = vim.tbl_extend(
			"keep",
			opts or {},
			{
				title = table.concat(command, " "),
				replace = notification,
				keep = function()
					return vim.g["notify_command_status"] == "running"
				end,
			}
		)
		notification = vim.notify(msg, level, notify_opts)
	end
	local on_data = function(_, data)
		output = output .. table.concat(data, "\n")
		notify(data, "info")
	end
	vim.fn.jobstart(command, {
		on_stdout = on_data,
		on_stderr = on_data,
		on_exit = function(_, code)
			local level = "info"
			local message = "Command finished."

			if code ~= 0 then
				level = "error"
				message = message .. " exit code: " .. code
			end

			notify(message, level)

			vim.g["_notify_command_result"] = output

			vim.cmd("cex g:_notify_command_result")

			vim.g["notify_command_status"] = "completed"
		end,
	})
EOF
endfunction
