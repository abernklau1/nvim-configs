local M = {}
-- Suppress "warning: multiple different client offset_encodings detected for buffer, this is not supported yet" for null-ls
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.null_ls = {
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
                    vim.lsp.buf.format({bufnr = bufnr, async = false})
                end
            })
        end
    end,
    on_init = function(new_client, _) new_client.offset_encoding = 'utf-16' end,

    null_ls.builtins.formatting.clang_format.with {filetypes = {"cpp", "c"}}
}

M.setup = function()
    local status_ok, null_ls_conf = pcall(require, "null-ls")
    if not status_ok then return end

    null_ls_conf.setup(M.null_ls)
end

return M
