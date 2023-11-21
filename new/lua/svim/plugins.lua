local status, lazy = pcall(require, "lazy")
if not status then
    print("lazy is not installed")
    return
end

return {
    -- Colorscheme
    {
        "abernklau1/offlucy.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme oh-lucy]])
        end
    }, -- Debugger
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }, {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
        opts = {handlers = {}}
    }, {"mfussenegger/nvim-dap"}, -- For semantic highlighting
    {
        "neovim/nvim-lspconfig",
        config = function() require("svim.core.lsp"):setup() end
    },
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua ---- Archived ----
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = function() require("svim.core.null_ls"):setup() end
    }, -- Required for null-ls
    {
        "nvim-lua/plenary.nvim",
        cmd = {"PlenaryBustedFile", "PlenaryBustedDirectory"},
        lazy = true
    }, -- Package Manager
    {
        "williamboman/mason.nvim",
        config = function() require("svim.core.mason"):setup() end,
        cmd = {
            "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll",
            "MasonLog"
        },
        build = function()
            pcall(function() require("mason-registry").refresh() end)
        end,
        event = "User FileOpened",
        lazy = true
    }, -- Extensible fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function() require("svim.core.telescope"):setup() end,
        dependencies = {"telescope-fzf-native.nvim"},
        lazy = true,
        cmd = "Telescope",
        enabled = true
    }, -- C port of fzf
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = {"nvim-cmp"},
        lazy = true,
        enabled = true
    }, -- Completion plugin
    {
        "hrsh7th/nvim-cmp",
        config = function() require("svim.core.cmp"):setup() end,
        event = "InsertEnter",
        dependencies = {"cmp-nvim-lsp", "cmp-buffer", "cmp-path", "cmp-cmdline"}
    }, -- nvim-cmp source for neovim's built-in language server client.
    {"hrsh7th/cmp-nvim-lsp", lazy = true}, -- nvim-cmp source for buffer words.
    {"hrsh7th/cmp-buffer", lazy = true},

    -- nvim-cmp source for filesystem paths.
    {"hrsh7th/cmp-path", lazy = true}, -- nvim-cmp source for vim's cmdline.
    {"hrsh7th/cmp-cmdline", lazy = true, enabled = true}, {
        "L3mon4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    }, -- Highlighting
    {
        "nvim-treesitter/nvim-treesitter",

        config = function() require("svim.core.treesitter"):setup() end,
        cmd = {
            "TSInstall", "TSUninstall", "TSUpdate", "TSUpdateSync",
            "TSInstallInfo", "TSInstallSync", "TSInstallFromGrammar"
        },
        event = "User FileOpened"
    }, -- Autopair plugin
    {
        "windwp/nvim-autopairs",
        -- event = "InsertEnter",
        config = function() require("svim.core.autopairs"):setup() end,
        enabled = true,
        dependencies = {"nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp"}
    }, -- NvimTree file explorer
    {
        "nvim-tree/nvim-tree.lua",
        config = function() require("svim.core.nvimtree"):setup() end,
        enabled = true,
        cmd = {
            "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus",
            "NvimTreeFindFileToggle"
        },
        event = "User DirOpened"
    }, -- Comments
    {
        "numToStr/Comment.nvim",
        config = function() require("svim.core.comment"):setup() end,
        keys = {{"gc", mode = {"n", "v"}}, {"gb", mode = {"n", "v"}}},
        event = "User FileOpened",
        enabled = true
    }, -- Icons
    {"nvim-tree/nvim-web-devicons", enabled = true, lazy = true},
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        config = function() require("svim.core.lualine"):setup() end,
        event = "VimEnter",
        enabled = true
    }, -- Files open at top
    {
        "akinsho/bufferline.nvim",
        config = function() require("svim.core.bufferline"):setup() end,
        branch = "main",
        -- lazy = true,
        -- event = "User FileOpened",
        enabled = true
    }, -- Terminal
    {
        "akinsho/toggleterm.nvim",
        branch = "main",
        config = function() require("svim.core.terminal") end,
        cmd = {
            "ToggleTerm", "TermExec", "ToggleTermToggleAll",
            "ToggleTermSendCurrentLine", "ToggleTermSendVisualLines",
            "ToggleTermSendVisualSelection"
        },
        enabled = true
    }, -- Handle whitespace
    {
        "ntpeters/vim-better-whitespace",
        config = function() require("svim.core.whitespace"):setup() end,
        enabled = true
    }, -- Coding stats
    {"wakatime/vim-wakatime", enabled = true}, -- Latex Support
    {
        "lervag/vimtex",
        config = function()
            require("vimtex").setup({
                vim.cmd([[
     let g:vimtex_view_method = 'skim'
     ]])
            })
        end,
        ft = {"tex"},
        enabled = true
    }, -- Doc comments for c++
    {"vim-scripts/DoxygenToolkit.vim", enabled = true}

}
