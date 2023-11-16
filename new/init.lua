-- disable netrw at the very start of your init.lua (strongly advised) ** For nvim-tree **
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load Core Plugins
-- Get Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable",     -- latest stable release
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load config settings

-- Space as leader
vim.g.mapleader = " "
require("svim.config.keymaps"):load_defaults()
require("svim.config.settings")

require("lazy").setup("svim.plugins", { ui = { border = "rounded" } })
