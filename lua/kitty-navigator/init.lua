local M = {}

local mappings = { h = "left", j = "bottom", k = "top", l = "right" }

function M.navigate(direction)
	local left_win = vim.fn.winnr("1" .. direction)
	if vim.fn.winnr() ~= left_win then
		vim.api.nvim_command("wincmd " .. direction)
	else
		local command = "kitty @ kitten navigate_kitty.py " .. mappings[direction]
		vim.fn.system(command)
	end
end

function M.navigateLeft()
	M.navigate("h")
end

function M.navigateRight()
	M.navigate("l")
end
function M.navigateUp()
	M.navigate("k")
end
function M.navigateDown()
	M.navigate("j")
end

---@param options Options
function M.setup(options)
	vim.keymap.set("n", options.keybindings.left or "<C-h>", M.navigateLeft, { silent = true })
	vim.keymap.set("n", options.keybindings.right or "<C-l>", M.navigateRight, { silent = true })
	vim.keymap.set("n", options.keybindings.up or "<C-k>", M.navigateUp, { silent = true })
	vim.keymap.set("n", options.keybindings.down or "<C-j>", M.navigateDown, { silent = true })
end

vim.api.nvim_create_user_command("NavigateLeft", M.navigateLeft, {})

return M
