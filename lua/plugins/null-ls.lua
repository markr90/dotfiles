local function null_ls_setup()
  local null_ls = require('null-ls')

  null_ls.setup {
    debounce = 150,
    autostart = true,
    sources = {
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
    }
  }
end

return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = null_ls_setup,
    enabled = require('gehaktmolen.constants').isWindows
  }
}
