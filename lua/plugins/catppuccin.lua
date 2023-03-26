local function setup_theme()
  require('catppuccin').setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    no_italic = true,
    integrations = {
      telescope = true,
      treesitter = true,
      cmp = true,
      gitsigns = true,
      native_lsp = {
        enabled = true,
      },
    }
  })

  vim.cmd.colorscheme 'catppuccin-mocha'
end

return {
  {
    'catppuccin/nvim',
    config = setup_theme,
  }
}
