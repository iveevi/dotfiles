local default_tasks_config = 'tasks.json'
local json = require('json')

-- TODO: global shared style and close on complete
-- TODO: option/keybind to open task config
local function neovim_tasks()
	-- Create a popup
	local Terminal = require('toggleterm.terminal').Terminal

	local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
	local result = handle:read('*a')
	result = result:gsub('%s+', '')
	handle:close()
	
	local is_git = (result == 'true')

	local root_dir = vim.fn.getcwd()
	if is_git then
		print('Git repo detected')

		-- Get root directory
		handle = io.popen('git rev-parse --show-toplevel')
		root_dir = handle:read('*a')
		root_dir = root_dir:gsub('%s+', '')
		handle:close()
	else
		print('No git repo detected')
	end

	print('Root dir is ' .. root_dir)

	local tasks_config = root_dir .. '/' .. default_tasks_config
	print('Tasks config is ' .. tasks_config)

	-- Check if tasks config exists, and prompt to create if not
	if not io.open(tasks_config, 'r') then
		print('Tasks config not found')
		local create = vim.fn.input('Create tasks config? (y/n) ')
		if create == 'y' then
			print('Creating tasks config')
			local file = io.open(tasks_config, 'w')
			file:write(json.encode({}))
			file:close()
		else
			print('Not creating tasks config')
			return
		end
	else
		print('Tasks config found')
	end
	
	-- Now read the tasks config
	local file = io.open(tasks_config, 'r')
	local tasks = json.decode(file:read('*a'))
	file:close()

	-- Show window of tasks
	local current_window = vim.api.nvim_get_current_win()

	local width = vim.api.nvim_win_get_width(current_window)
	local height = vim.api.nvim_win_get_height(current_window)

	local buf = vim.api.nvim_create_buf(false, true)

	-- Highlight everything transparent

	-- TODO: buffer config method
	
	-- Make window transparent background via highlight
	
	local menu_window = vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = 20,
		height = 10,
		row = height / 2,
		col = width / 2,
		style = 'minimal',
		border = 'rounded',
	})

	-- Fill with tasks
	local lines = {}
	local task_list = {}
	local index = 1

	for i, task in ipairs(tasks) do
		table.insert(lines, task.command)
		task_list[index] = task
		index = index + 1
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Map keys in the buffer
	-- TODO: multiple per function
	vim.keymap.set('n', '<CR>', function()
		local current_line = vim.api.nvim_win_get_cursor(menu_window)[1]
		local task = task_list[current_line]

		if task.directory == nil then
			task.directory = '.'
		end

		if task.close == nil then
			task.close = true
		end

		print('Running task ' .. task.command .. ' in ' .. task.directory .. ' with close ' .. tostring(task.close))

		-- Run the task
		local terminal = Terminal:new({
			cmd = task.command,
			dir = root_dir .. '/' .. task.directory,
			direction = 'tab',
			-- TODO: config to choose direction... (and also JSON)
			hidden = true,
			close_on_exit = false,
			on_exit = function(terminal, job, exit_code, name)
				if exit_code == 0 and task.close then
					terminal:close()
				end
			end,
		})

		terminal:open()

		-- Then remove the window
		vim.api.nvim_win_close(menu_window, true)
	end, { buffer = buf })

	-- Open task config on 'e'
	vim.keymap.set('n', 'e', function()
		vim.api.nvim_win_close(menu_window, true)
		vim.cmd('edit ' .. tasks_config)
	end, { buffer = buf })

	-- Close on escape
	vim.keymap.set('n', '<Esc>', function()
		vim.api.nvim_win_close(menu_window, true)
	end, { buffer = buf })
	
	-- Disable modifiable
	-- vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

-- Setup routine for the plugin
local function setup()
	-- TODO: actual parameters
	vim.keymap.set('n', '<F7>', neovim_tasks)
	vim.keymap.set('i', '<F7>', neovim_tasks)
end

return {
	setup = setup,
}
