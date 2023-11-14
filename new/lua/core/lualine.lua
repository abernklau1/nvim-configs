local lualine = {}

local status_ok, lualine_conf = pcall(require, "lualine")
if not status_ok then return end

lualine_conf.setup(lualine)
