-- Load Core Plugins
-- Get Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branc`=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load config settings

-- Space as leader
vim.g.mapleader = " "
require("svim.config.keymaps"):load_defaults()
require("svim.config.settings")

local plugins = require("svim.plugins")

require("lazy").setup(plugins)
