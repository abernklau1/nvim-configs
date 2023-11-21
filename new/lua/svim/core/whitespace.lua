local M = {}

M.setup = function()
	vim.g.strip_whitespace_on_save = 1

	vim.g.better_whitespace_filetypes_blacklist = {
		"terminal", "nofile", "markdown", "help", "startify", "dashboard",
		"packer", "neogitstatus", "NvimTree", "Trouble", "toggleterm"
	}
end

return M
