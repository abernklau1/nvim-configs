local icons = require("svim.icons")

---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme
local actions =
    require("svim.utils.modules").require_on_exported_call "telescope.actions"

local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"

local M = {}

M.telescope = {
    theme = "dropdown", ---@type telescope_themes
    defaults = {
        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = icons.ui.Forward .. " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = nil,
        layout_strategy = nil,
        layout_config = {},
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--hidden",
            "--glob=!.git/"
        },
        ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
        mappings = {
            i = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
                ["<C-q>"] = function(...)
                    actions.smart_send_to_qflist(...)
                    actions.open_qflist(...)
                end,
                ["<CR>"] = actions.select_default
            },
            n = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-q>"] = function(...)
                    actions.smart_send_to_qflist(...)
                    actions.open_qflist(...)
                end
            }
        },
        file_ignore_patterns = {},
        path_display = {"smart"},
        winblend = 0,
        border = {},
        borderchars = nil,
        color_devicons = true,
        set_env = {["COLORTERM"] = "truecolor"} -- default = nil,
    },
    pickers = {
        find_files = {hidden = true},
        live_grep = {
            -- @usage don't include the filename in the search results
            only_sort_text = true
        },
        grep_string = {only_sort_text = true},
        buffers = {
            initial_mode = "normal",
            mappings = {
                i = {["<C-d>"] = actions.delete_buffer},
                n = {["dd"] = actions.delete_buffer}
            }
        },
        planets = {show_pluto = true, show_moon = true},
        git_files = {hidden = true, show_untracked = true},
        colorscheme = {enable_preview = true}
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
        }
    }
}

M.telescope = vim.tbl_extend("keep", {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter
}, M.telescope)

local theme = require("telescope.themes")["get_" .. (M.telescope.theme or "")]
if theme then M.telescope.defaults = theme(M.telescope.defaults) end

M.setup = function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then return end
    telescope.setup(M.telescope)

    if telescope.extensions and telescope.extensions.fzf then
        pcall(function() require("telescope").load_extension "fzf" end)
    end
end

return M
