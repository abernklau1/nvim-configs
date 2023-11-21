local M = {}

M.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                                                                  .make_client_capabilities())

M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.clangd = {
    cmd = {
        "clangd", "--background-index", "--pch-storage=memory", "--clang-tidy",
        "--suggest-missing-includes", "--all-scopes-completion", "--pretty",
        "--header-insertion=never", "-j=4", "--inlay-hints",
        "--header-insertion-decorators"
    },
    filetypes = {"c", "cpp", "objc", "objcpp"},
    -- root_dir = utils.root_pattern(".config", ".clang-tidy", ".clang-format", compile_commands.json", "compile_flags.txt", ".git", "config.yaml"),
    init_options = {fallbackFlags = {"-std=c++2a"}},
    capabilities = M.capabilities
}

M.lua_ls = {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            }
        }
    },
    capabilities = M.capabilities
}

M.setup = function()
    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then return end

    lspconfig.clangd.setup(M.clangd)
    lspconfig.lua_ls.setup(M.lua_ls)
end

return M
