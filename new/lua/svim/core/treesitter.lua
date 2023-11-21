local M = {}

M.treesitter = {

    -- A list of parser names, or "all"
    ensure_installed = {"comment", "markdown_inline", "regex"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    matchup = {
        enable = false -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
            if vim.tbl_contains({"latex"}, lang) then return true end

            local status_ok, big_file_detected =
                pcall(vim.api.nvim_buf_get_var, buf,
                      "bigfile_disable_treesitter")
            return status_ok and big_file_detected
        end
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
            -- Languages that have a single comment style
            typescript = "// %s",
            css = "/* %s */",
            scss = "/* %s */",
            html = "<!-- %s -->",
            svelte = "<!-- %s -->",
            vue = "<!-- %s -->",
            json = ""
        }
    },
    indent = {enable = true, disable = {"yaml", "python"}},
    autotag = {enable = false},
    textobjects = {swap = {enable = false}, select = {enable = false}},
    textsubjects = {
        enable = false,
        keymaps = {["."] = "textsubjects-smart", [";"] = "textsubjects-big"}
    }
}

M.setup = function()
    local status_ok, treesitter_conf = pcall(require, "nvim-treesitter.configs")
    if not status_ok then return end

    treesitter_conf.setup(M.treesitter)

    -- handle deprecated API, https://github.com/windwp/nvim-autopairs/pull/324
    local ts_utils = require "nvim-treesitter.ts_utils"
    ts_utils.is_in_node_range = vim.treesitter.is_in_node_range
    ts_utils.get_node_range = vim.treesitter.get_node_range
end

return M
