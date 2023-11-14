local icons = require("svim.icons")

    local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
    if not status_cmp_ok then return end
    local ConfirmBehavior = cmp_types.ConfirmBehavior

    local cmp = require("svim.utils.modules").require_on_index "cmp"
    local luasnip = require("svim.utils.modules").require_on_index "luasnip"
    local cmp_window = require "cmp.config.window"


    cmp = {
        active = true,
        on_config_done = nil,
        enabled = function()
            local buftype = vim.api.nvim_buf_get_option(0, "buftype")
            if buftype == "prompt" then return false end
            return cmp.active
        end,
        confirm_opts = {behavior = ConfirmBehavior.Replace, select = false},
        completion = {
            ---@usage The minimum length of a word to complete on.
            keyword_length = 1
        },
        experimental = {ghost_text = false, native_menu = false},
        formatting = {
            fields = {"kind", "abbr", "menu"},
            max_width = 0,
            kind_icons = icons.kind,
            source_names = {
                nvim_lsp = "(LSP)",
                emoji = "(Emoji)",
                path = "(Path)",

                vsnip = "(Snippet)",
                luasnip = "(Snippet)",
                buffer = "(Buffer)",
                treesitter = "(TreeSitter)"
            },
            duplicates = {buffer = 1, path = 1, nvim_lsp = 0, luasnip = 1},
            duplicates_default = 0,
                    },
        snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
        window = {
            completion = cmp_window.bordered(),
            documentation = cmp_window.bordered()
        },
        sources = {
            {
                -- keyword_length = 0,
                max_item_count = 3,
                trigger_characters = {
                    {
                        ".", ":", "(", "'", '"', "[", ",", "#", "*", "@", "|",
                        "=", "-", "{", "/", "\\", "+", "?", " "
                        -- "\t",
                        -- "\n",
                    }
                }
            }, {
                name = "nvim_lsp",
                entry_filter = function(entry, ctx)
                    local kind =
                        require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                    if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                        return false
                    end
                    return true
                end
            }, {name = "path"}, {name = "luasnip"},
            {name = "nvim_lua"}, {name = "buffer"}, {name = "calc"},
            {name = "emoji"}, {name = "treesitter"},
            {name = "tmux"}
        },
        		    }



    local cmp_conf = require "cmp"
    cmp_conf.setup(cmp)

    if cmp.on_config_done then cmp.on_config_done(cmp) end


