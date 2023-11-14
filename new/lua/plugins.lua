return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = {"mason-lspconfig.nvim", "nlsp-settings.nvim"}
    }, -- Fill gaps between Mason & LSP
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = {"LspInstall", "LspUninstall"},
        config = function()
            -- automatic_installation is handled by lsp-manager
            local settings = require "mason-lspconfig.settings"
            settings.current.automatic_installation = true -- For now, until lsp-manager is setup
        end,
        lazy = true,
        event = "User FileOpened",
        dependencies = "mason.nvim"
    }, -- Use json/yaml to configure LSP
    {"tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true},

    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua ---- Archived ----
    {"jose-elias-alvarez/null-ls.nvim", lazy = true}, -- Easy Logging
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
        enabled = true -- svim.builtin.telescope.active
    }, -- C port of fzf
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = {"nvim-cmp"},
        lazy = true,
        enabled = true -- svim.builtin.telescope.active
    }, -- Completion plugin
    {
        "hrsh7th/nvim-cmp",
        config = function() require("svim.core.cmp").setup() end,
        event = {"InsertEnter", "CmdlineEnter"},
        dependencies = {"cmp-nvim-lsp", "cmp-buffer", "cmp-path", "cmp-cmdline"}
    }, -- nvim-cmp source for neovim's built-in language server client.
    {"hrsh7th/cmp-nvim-lsp", lazy = true}, -- nvim-cmp source for buffer words.
    {"hrsh7th/cmp-buffer", lazy = true},

    -- nvim-cmp source for filesystem paths.
    {"hrsh7th/cmp-path", lazy = true}, -- nvim-cmp source for vim's cmdline.
    {
        "hrsh7th/cmp-cmdline",
        lazy = true,
        enabled = true -- svim.builtin.cmp and svim.builtin.cmp.cmdline.enable or false
    }, -- Autopair plugin
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require("svim.core.autopairs") end,
        enabled = true, -- svim.builtin.autopairs.active,
        dependencies = {"nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp"}
    }, -- Highlighting
    {
        "nvim-treesitter/nvim-treesitter",

        config = function()
            -- local utils = require "svim.utils"
            -- local path = utils.join_paths(get_runtime_dir(), "site", "pack",
            --                             "lazy", "opt", "nvim-treesitter")
            -- vim.opt.rtp:prepend(path) -- treesitter needs to be before nvim's runtime in rtp
            require("svim.core.treesitter").setup()
        end,
        cmd = {
            "TSInstall", "TSUninstall", "TSUpdate", "TSUpdateSync",
            "TSInstallInfo", "TSInstallSync", "TSInstallFromGrammar"
        },
        event = "User FileOpened"
    }, -- NvimTree file explorer
    {
        "nvim-tree/nvim-tree.lua",
        config = function() require("svim.core.nvimtree") end,
        enabled = true, -- svim.builtin.nvimtree.active,
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
        enabled = true -- svim.builtin.comment.active
    }, -- Icons
    {"nvim-tree/nvim-web-devicons", enabled = true, true, lazy = true}, -- Status Line and Bufferline
    {
        "nvim-lualine/lualine.nvim",
        config = function() require("svim.core.lualine") end,
        event = "VimEnter",
        enabled = true -- svim.builtin.lualine.active
    }, {
        "akinsho/bufferline.nvim",
        config = function() require("svim.core.bufferline").setup() end,
        branch = "main",
        event = "User FileOpened",
        enabled = true -- svim.builtin.bufferline.active
    }, -- Terminal
    {
        "akinsho/toggleterm.nvim",
        branch = "main",
        init = function() require("svim.core.terminal").init() end,
        config = function() require("svim.core.terminal").setup() end,
        cmd = {
            "ToggleTerm", "TermExec", "ToggleTermToggleAll",
            "ToggleTermSendCurrentLine", "ToggleTermSendVisualLines",
            "ToggleTermSendVisualSelection"
        },
        -- keys = svim.builtin.terminal.open_mapping,
        enabled = true -- svim.builtin.terminal.active
    }, -- Handle whitespace
    {
        "ntpeters/vim-better-whitespace",
        config = function() require("svim.core.whitespace").setup() end,
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
        lazy = true,
        enabled = true,
        config = function()
            -- load colorscheme
            vim.cmd([[colorscheme oh-lucy]])
        end
    }

}
