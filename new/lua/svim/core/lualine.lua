local M = {}

M.lualine = {}

M.setup = function()
    local status_ok, lualine_conf = pcall(require, "lualine")
    if not status_ok then return end

    lualine_conf.setup( -- M.lualine
    )
end
return M
