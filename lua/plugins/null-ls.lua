-- null-ls is only used for eslint formatting and diagnostics due to bug with windows and eslint in native-lsp
local function eslint_cwd()
  local h = require('null-ls.helpers')
  local u = require('null-ls.utils')
  return h.cache.by_bufnr(function(params)
    return u.root_pattern(
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json"
    )(params.bufname)
  end)
end
local function null_ls_setup()
  local null_ls = require('null-ls')

  null_ls.setup {
    debounce = 150,
    autostart = true,
    sources = {
      null_ls.builtins.formatting.eslint_d.with({ cwd = eslint_cwd() }),
      null_ls.builtins.diagnostics.eslint_d.with({ cwd = eslint_cwd() }),
      null_ls.builtins.code_actions.eslint_d.with({ cwd = eslint_cwd() }),
    },
    on_attach = require('gehaktmolen.on-attach').on_attach,
    root_dir = require("null-ls.utils").root_pattern(".git"),
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
