local icons = require("svim.icons")

local M = {}

M.load_default_options = function()
    local default_options = {
        autochdir = true, -- nvim changes to current working directory
        clipboard = "unnamedplus", -- nvim access system clipboard
        cmdheight = 1, -- more space in nvim command line
        conceallevel = 0, -- so that `` is visible in markdown
        cursorline = true, -- highlight current line
        fileencoding = "utf-8",
        hlsearch = true, -- highlight matches of search
        ignorecase = false, -- ignore case in search
        number = true, -- numbered lines
        numberwidth = 2, -- set number column width
        pumheight = 10, -- pop-up menu height
        relativenumber = true, -- show number relative to current line
        scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
        sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor
        shiftwidth = 2, -- number of spaces inserted for indents
        showmode = false, -- shows current mode
        showtabline = 1,
        signcolumn = "yes",
        smartcase = true,
        smartindent = false,
        splitbelow = true, -- force hsplits below current window
        splitright = true, -- force vsplits right of current window
        tabstop = 2, -- insert 2 spaces for a tab
        termguicolors = true,
        title = true, -- set title of the window to value of title sting
        updatetime = 100, -- faster completion
        wrap = false
    }

    --- SETTINGS ---
    vim.opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu
    vim.opt.shortmess:append "I" -- don't show default intro message

    for k, v in pairs(default_options) do vim.opt[k] = v end

    vim.filetype.add {
        extension = {tex = "tex"},
        pattern = {["[jt]sconfig.*.json"] = "jsonc"}
    }

    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                {name = "DiagnosticSignError", text = icons.diagnostics.Error},
                {name = "DiagnosticSignWarn", text = icons.diagnostics.Warning},
                {name = "DiagnosticSignHint", text = icons.diagnostics.Hint},
                {
                    name = "DiagnosticSignInfo",
                    text = icons.diagnostics.Information
                }
            }
        },

        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = ""
        }
    }

    vim.diagnostic.config(default_diagnostic_config)
end

M.load_defaults = function() M.load_default_options() end

return M
