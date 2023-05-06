local function setup_theme()
  local utils = require('catppuccin.utils.colors')
  local mochaPalette = require('catppuccin.palettes').get_palette('mocha')
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

  local highlight_cursor = utils.blend(mochaPalette.surface1, mochaPalette.mantle, 0.3)

  vim.cmd('hi MiniCursorwordCurrent guibg=' .. highlight_cursor .. ' gui=none')
  vim.cmd('hi MiniCursorword guibg=' .. highlight_cursor .. ' gui=none')
  vim.cmd.colorscheme 'catppuccin-mocha'
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = setup_theme,
  }
}
