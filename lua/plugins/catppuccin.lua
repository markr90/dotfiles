local function setup_theme()
  require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    no_italic = true,
    highlight_overrides = {
      mocha = function(mocha)
        return {
          MiniIndentscopeSymbol = { fg = mocha.overlay0 },
        }
      end,
    },
    integrations = {
      telescope = true,
      treesitter = true,
      cmp = true,
      gitsigns = true,
      native_lsp = {
        enabled = true,
      },
      neotree = true,
      barbar = true,
      harpoon = true,
    }
  })

  vim.cmd.colorscheme 'catppuccin-mocha'
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = setup_theme,
  }
}
