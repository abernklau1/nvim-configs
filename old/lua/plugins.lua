local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") ..
                             "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git", "clone", "--depth", '1',
            "https://github.com/wbthomason/packer.nvim", install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use "neovim/nvim-lspconfig"
    use "nvim-treesitter/nvim-treesitter"
    use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
    use "akinsho/toggleterm.nvim"
    use "ntpeters/vim-better-whitespace"
    use "windwp/nvim-autopairs"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    -- use "kdheepak/cmp-latex-symbols",
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
    use "wakatime/vim-wakatime"

    ------ Color Schemes ---------
    use "dotsilas/darcubox-nvim"

    -- Slight variation of Yazeed1s/oh-lucy.nvim
    use "abernklau1/oh-lucy.nvim"

    -------------------------------

    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use {
        "lervag/vimtex",
        config = function()
            vim.cmd([[
     let g:vimtex_view_method = 'skim'
     ]])
        end,
        ft = {"tex"}
    }

    use "williamboman/mason.nvim"
    use {
        "williamboman/mason-lspconfig.nvim",
        cmd = {"LspInstall", "LspUninstall"},
        -- config = function()
        -- require("mason-lspconfig").setup(lvim.lsp.installer.setup)

        -- automatic_installation is handled by lsp-manager
        -- local settings = require "mason-lspconfig.settings"
        -- settings.current.automatic_installation = false
        -- end,
        -- lazy = true,
        event = "User FileOpened",
        dependencies = "mason.nvim"
    }

    use {
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup() end
    }
    use "jose-elias-alvarez/null-ls.nvim"
    use "nvim-lua/plenary.nvim"

    use "vim-scripts/DoxygenToolkit.vim"
    if packer_bootstrap then require("packer").sync() end
end)
