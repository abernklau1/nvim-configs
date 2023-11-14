-- Use a loop to conveniently call 'setup' on multiple servers
local servers = {'clangd', 'zls', 'pyright', 'ltex', 'lua_ls'}
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150
        }
    }
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
                                                                      .protocol
                                                                      .make_client_capabilities())

local lsp = {
    cmd = {
        "clangd", "--background-index", "--pch-storage=memory", "--clang-tidy",
        "--suggest-missing-includes", "--all-scopes-completion", "--pretty",
        "--header-insertion=never", "-j=4", "--inlay-hints",
        "--header-insertion-decorators"
    },
    filetypes = {"c", "cpp", "objc", "objcpp"},
    -- root_dir = utils.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
    init_option = {fallbackFlags = {"-std=c++2a"}}
}
local zls = {capabilities = capabilities}

local pyright = {capabilities = capabilities}

local lua_ls = {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            }
        }
    }
}

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then return end
lspconfig.setup(lsp)
lspconfig.zls.setup(zls)
lspconfig.pyright.setup(pyright)
lspconfig.lua_ls.setup(lua_ls)
