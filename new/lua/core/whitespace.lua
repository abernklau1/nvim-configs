local M = {}

function M.config()
    whitespace = {
        strip_whitespace_on_save = 1,

        better_whitespace_filetypes_blacklist = {
            "terminal", "nofile", "markdown", "help", "startify", "dashboard",
            "packer", "neogitstatus", "NvimTree", "Trouble", "toggleterm"
        },
        on_config_done = nil
    }
end

function M.setup()
    local whitespace_conf = require "vim-better-whitespace"

    whitespace_conf.setup(whitespace)
    if whitespace.on_config_done then whitespace.on_config_done(whitespace) end
end

return M
