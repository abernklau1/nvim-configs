return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {"mason-lspconfig.nvim", "nlsp-settings.nvim"}
    }, -- Fill gaps between Mason & LSP
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = {"LspInstall", "LspUninstall"},
        config = function()
            -- automatic_installation is handled by lsp-manager
            local settings = require "mason-lspconfig.settings"
            settings.current.automatic_installation = true -- For now, until lsp-manager is setup
            require("svim.core.lsp")
        end,
        lazy = true,
        event = "User FileOpened",
        dependencies = "mason.nvim"
    }, -- Use json/yaml to configure LSP
    {"tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true},

    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua ---- Archived ----
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function() require("svim.core.null_ls") end
    }, -- Easy Logging
    {"Tastyep/structlog.nvim", lazy = true}, -- Required for null-ls
    {
        "nvim-lua/plenary.nvim",
        cmd = {"PlenaryBustedFile", "PlenaryBustedDirectory"},
        lazy = true
    }, -- Package Manager
    {
        "williamboman/mason.nvim",
        config = function() require("svim.core.mason") end,
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
        config = function() require("svim.core.telescope") end,
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
        config = function() require("svim.core.cmp") end,
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
    }, -- Autopair plugin
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require("svim.core.autopairs") end,
        enabled = true,
        dependencies = {"nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp"}
    }, -- Highlighting
    {
        "nvim-treesitter/nvim-treesitter",

        config = function() require("svim.core.treesitter") end,
        cmd = {
            "TSInstall", "TSUninstall", "TSUpdate", "TSUpdateSync",
            "TSInstallInfo", "TSInstallSync", "TSInstallFromGrammar"
        },
        event = "User FileOpened"
    }, -- NvimTree file explorer
    {
        "nvim-tree/nvim-tree.lua",
        config = function() require("svim.core.nvimtree") end,
        enabled = true,
        cmd = {
            "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus",
            "NvimTreeFindFileToggle"
        },
        event = "User DirOpened"
    }, -- Comments
    {
        "numToStr/Comment.nvim",
        config = function() require("svim.core.comment") end,
        keys = {{"gc", mode = {"n", "v"}}, {"gb", mode = {"n", "v"}}},
        event = "User FileOpened",
        enabled = true
    }, -- Icons
    {"nvim-tree/nvim-web-devicons", enabled = true, lazy = true}, -- Status Line and Bufferline
    {
        "nvim-lualine/lualine.nvim",
        config = function() require("svim.core.lualine") end,
        event = "VimEnter",
        enabled = true
    }, {
        "akinsho/bufferline.nvim",
        config = function() require("svim.core.bufferline") end,
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
        config = function() require("svim.core.whitespace") end,
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
    {"vim-scripts/DoxygenToolkit.vim", enabled = true}, -- Color Schemes
    {
        "abernklau1/oh-lucy.nvim",
        enabled = true,
        config = function()
            -- load colorscheme
            vim.cmd("colorscheme oh-lucy")
        end,
        lazy = false,
        priority = 1000
    }

}
