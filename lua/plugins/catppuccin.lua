local function setup_theme()
  require('catppuccin').setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    no_italic = true,
    highlight_overrides = {
      mocha = function(mocha)
        return {
          BufferCurrent = { bg = mocha.mantle, fg = mocha.text },
          BufferCurrentERROR = { bg = mocha.mantle, fg = mocha.red },
          BufferCurrentWARN = { bg = mocha.mantle, fg = mocha.peach },
          BufferCurrentIndex = { bg = mocha.mantle, fg = mocha.blue },
          BufferCurrentMod = { bg = mocha.mantle, fg = mocha.yellow },
          BufferCurrentSign = { bg = mocha.mantle, fg = mocha.blue },
          BufferCurrentTarget = { bg = mocha.mantle, fg = mocha.red },
          BufferCurrentIcon = { bg = mocha.mantle },
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
      -- nvimtree = true,
      neotree = true,
      barbar = true,
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
