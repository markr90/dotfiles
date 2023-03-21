local lsp = require('lsp-zero').preset("recommended")

lsp.skip_server_setup({'eslint'})
lsp.setup()

local null_ls = require 'null-ls'

null_ls.setup {
    debounce = 150,
    autostart = true,
    sources = {
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
    },
}

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = true,
})

