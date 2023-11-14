-- disable netrw at the very start of your init.lua (strongly advised) ** For nvim-tree **
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("original.plugins")

-- Suppress "warning: multiple different client offset_encodings detected for buffer, this is not supported yet" for null-ls
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

-- local utils = require "lua.utils"

-- Space as leader
vim.g.mapleader = " "

-- lsp config
require("original.lsp")

-- lualine
require("lualine").setup()

-- nvim-treesitter
require("nvim-treesitter.configs").setup {highlight = {enable = true}}

require("nvim-autopairs").setup {}

-- null-ls

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.formatting.lua_format
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({async = false})
                end
            })
        end
    end,
    on_init = function(new_client, _) new_client.offset_encoding = 'utf-16' end,

    null_ls.builtins.formatting.clang_format.with {filetypes = {"cpp", "c"}}
})

-- Mason
require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        width = 0.8,
        height = 0.9,
        border = "rounded",
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>"
        }
    },

    icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍"
    },

    -- NOTE: should be available in $PATH
    -- install_root_dir = join_paths(vim.fn.stdpath "data", "mason"),

    -- NOTE: already handled in the bootstrap stage
    -- PATH = "skip",

    pip = {
        upgrade_pip = false,
        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
        -- and is not recommended.
        --
        -- Example: { "--proxy", "https://proxyserver" }
        install_args = {}
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,

    -- [Advanced setting]
    -- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
    -- multiple registries, the registry listed first will be used.
    registries = {"lua:mason-registry.index", "github:mason-org/mason-registry"},

    -- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
    -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
    providers = {"mason.providers.registry-api", "mason.providers.client"},

    github = {
        -- The template URL to use when downloading assets from GitHub.
        -- The placeholders are the following (in order):
        -- 1. The repository (e.g. "rust-lang/rust-analyzer")
        -- 2. The release version (e.g. "v0.3.0")
        -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
        download_url_template = "https://github.com/%s/releases/download/%s/%s"
    },

    on_config_done = nil
})

-- Terminal

require("toggleterm").setup({
    active = true,
    on_config_done = nil,
    -- size can be a number or function which is passed the current terminal
    size = 12,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "horizontal",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = "curved",
        -- width = <value>,
        -- height = <value>,
        winblend = 0,
        highlights = {border = "Normal", background = "Normal"}
    }
    -- Add executables on the config.lua
    -- { cmd, keymap, description, direction, size }
    -- lvim.builtin.terminal.execs = {...} to overwrite
    -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    -- TODO: pls add mappings in which key and refactor this
})

-- Colorscheme

vim.cmd("colorscheme oh-lucy")

-- option ** Finished Abstraction
vim.opt.autochdir = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.showtabline = 1
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.title = true
vim.opt.wrap = false
vim.opt.shiftwidth = 2

-- nvim-tree
require("nvim-tree").setup({
    view = {
        width = 30,
        -- hide_root_folder = false,
        side = "left",
        number = false,
        relativenumber = false,
        signcolumn = "yes"
    },
    renderer = {group_empty = true},
    filters = {dotfiles = true}
})

---------------- Buffer Close Command Function --------------------------

-- Common kill function for bdelete and bwipeout
-- credits: based on bbye and nvim-bufdel
---@param kill_command? string defaults to "bd"
---@param bufnr? number defaults to the current buffer
---@param force? boolean defaults to false
local function buf_kill(kill_command, bufnr, force)
    kill_command = kill_command or "bd"

    local bo = vim.bo
    local api = vim.api
    local fmt = string.format
    local fn = vim.fn

    if bufnr == 0 or bufnr == nil then bufnr = api.nvim_get_current_buf() end

    local bufname = api.nvim_buf_get_name(bufnr)

    if not force then
        local choice
        if bo[bufnr].modified then
            choice = fn.confirm(fmt([[Save changes to "%s"?]], bufname),
                                "&Yes\n&No\n&Cancel")
            if choice == 1 then
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("w")
                end)
            elseif choice == 2 then
                force = true
            else
                return
            end
        elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
            choice = fn.confirm(fmt([[Close "%s"?]], bufname),
                                "&Yes\n&No\n&Cancel")
            if choice == 1 then
                force = true
            else
                return
            end
        end
    end

    -- Get list of windows IDs with the buffer to close
    local windows = vim.tbl_filter(function(win)
        return api.nvim_win_get_buf(win) == bufnr
    end, api.nvim_list_wins())

    if force then kill_command = kill_command .. "!" end

    -- Get list of active buffers
    local buffers = vim.tbl_filter(function(buf)
        return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
    end, api.nvim_list_bufs())

    -- If there is only one buffer (which has to be the current one), vim will
    -- create a new buffer on :bd.
    -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
    if #buffers > 1 and #windows > 0 then
        for i, v in ipairs(buffers) do
            if v == bufnr then
                local prev_buf_idx = i == 1 and #buffers or (i - 1)
                local prev_buffer = buffers[prev_buf_idx]
                for _, win in ipairs(windows) do
                    api.nvim_win_set_buf(win, prev_buffer)
                end
            end
        end
    end

    -- Check if buffer still exists, to ensure the target buffer wasn't killed
    -- due to options like bufhidden=wipe.
    if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
        vim.cmd(string.format("%s %d", kill_command, bufnr))
    end
end

-------------------------------------------------------------------------

-- Bufferline
require("bufferline").setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
        close_command = function(bufnr) -- can be a string | function, see "Mouse actions"
            buf_kill("bd", bufnr, false)
        end,
        right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match "%.md" then
                return vim.fn.fnamemodify(buf.name, ":t:r")
            end
        end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        --- count is an integer representing total count of errors
        --- level is a string "error" | "warning"
        --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
        --- this should return a string
        --- Don't get too fancy as this function will be executed a lot
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,

        custom_filter = custom_filter,
        offsets = {
            {
                filetype = "undotree",
                text = "Undotree",
                highlight = "PanelHeading",
                padding = 1
            }, {
                filetype = "NvimTree",
                text = "Explorer",
                highlight = "PanelHeading",
                padding = 1
            }, {
                filetype = "DiffviewFiles",
                text = "Diff View",
                highlight = "PanelHeading",
                padding = 1
            }, {
                filetype = "flutterToolsOutline",
                text = "Flutter Outline",
                highlight = "PanelHeading"
            },
            {
                filetype = "lazy",
                text = "Lazy",
                highlight = "PanelHeading",
                padding = 1
            }
        },
        color_icons = true -- whether or not to add the filetype icon highlights
    }
}

-- Vim Better Whitespace

vim.g.strip_whitespace_on_save = 1

vim.g.better_whitespace_filetypes_blacklist = {
    "terminal", "nofile", "markdown", "help", "startify", "dashboard", "packer",
    "neogitstatus", "NvimTree", "Trouble", "toggleterm"
}

------------------- keymappings -------------------------------------------

-- nvim-tree
vim.api.nvim_set_keymap('n', "<leader>e", "<cmd>NvimTreeToggle<CR>", {})

-- Horizontal Terminal Mapping
vim.api.nvim_set_keymap('n', "<leader>t", "<cmd>ToggleTerm<CR>", {})

-- C++ Compile Command
vim.api
    .nvim_set_keymap('n', "<leader>a", "<cmd>make build<CR><cmd>./%<<CR>", {})

-- Better Window Movement
vim.api.nvim_set_keymap('n', "<C-h>", "<C-w>h", {})
vim.api.nvim_set_keymap('n', "<C-j>", "<C-w>j", {})
vim.api.nvim_set_keymap('n', "<C-k>", "<C-w>k", {})
vim.api.nvim_set_keymap('n', "<C-l>", "<C-w>l", {})

-- Terminal Navigation
vim.api.nvim_set_keymap('t', "<C-h>", "<C-\\><C-N><C-w>h", {})
vim.api.nvim_set_keymap('t', "<C-j>", "<C-\\><C-N><C-w>j", {})
vim.api.nvim_set_keymap('t', "<C-k>", "<C-\\><C-N><C-w>k", {})
vim.api.nvim_set_keymap('t', "<C-l>", "<C-\\><C-N><C-w>l", {})

-- Comment
vim.api.nvim_set_keymap('v', "<leader>/", "gc", {})

-- LSP Diagnostics
vim.api.nvim_set_keymap('n', "<leader>d",
                        "<cmd>lua vim.diagnostic.open_float({bufnr=0})<CR>", {})

-- Bufferline
vim.api.nvim_set_keymap('n', "<leader>s", "<cmd>BufferLinePick<CR>", {})
vim.api.nvim_set_keymap('n', "<leader>b", "<cmd>BufferLineCyclePrev<CR>", {})
vim.api.nvim_set_keymap('n', "<leader>n", "<cmd>BufferLineCycleNext<CR>", {})
vim.api.nvim_set_keymap('n', "<leader>c", "<cmd>BufferLinePickClose<cr>", {})

-- Create Splits

-- hsplit
vim.api.nvim_set_keymap('n', "<leader>h", "<cmd>split<CR>", {})
-- vsplit
vim.api.nvim_set_keymap('n', "<leader>v", "<cmd>vsplit<CR>", {})

-- Doxygen
vim.api.nvim_set_keymap('n', "<leader>D", "<cmd>Dox<CR>", {})
