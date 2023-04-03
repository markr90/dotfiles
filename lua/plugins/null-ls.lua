-- null-ls is only used for eslint formatting and diagnostics due to bug with windows and eslint in native-lsp
local function null_ls_setup()
  local null_ls = require('null-ls')

  null_ls.setup {
    debounce = 150,
    autostart = true,
    sources = {
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
    },
    on_attach = require('gehaktmolen.on-attach').on_attach,
  }
end

return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'joechrisellis/lsp-format-modifications.nvim',
    },
    config = null_ls_setup,
  }
}
