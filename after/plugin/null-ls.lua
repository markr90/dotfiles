local null_ls = require 'null-ls'

null_ls.setup {
  debounce = 150,
  autostart = true,
  sources = {
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
  }
}
