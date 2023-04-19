local function setup_theme()
  local utils = require('catppuccin.utils.colors')
  local mochaPalette = require('catppuccin.palettes').get_palette('mocha')
  local blend = function(fg)
    return utils.blend(fg, mochaPalette.mantle, 0.4)
  end
  require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    no_italic = true,
    highlight_overrides = {
      mocha = function(mocha)
        return {
          BufferCurrent = { bg = mocha.surface0, fg = mocha.text },
          BufferCurrentIndex = { bg = mocha.surface0, fg = mocha.blue },
          BufferCurrentMod = { bg = mocha.surface0, fg = mocha.yellow },
          BufferCurrentSign = { bg = mocha.surface0, fg = mocha.blue },
          BufferCurrentTarget = { bg = mocha.surface0, fg = mocha.red },
          BufferCurrentERROR = { bg = mocha.surface0, fg = mocha.red },
          BufferCurrentWARN = { bg = mocha.surface0, fg = mocha.yellow },
          BufferVisibleERROR = { bg = mocha.mantle, fg = mocha.yellow },
          BufferVisibleWARN = { bg = mocha.mantle, fg = mocha.red },
          BufferAlternateERROR = { bg = mocha.mantle, fg = blend(mocha.red) },
          BufferAlternateWARN = { bg = mocha.mantle, fg = blend(mocha.yellow) },
          BufferInactiveERROR = { bg = mocha.mantle, fg = blend(mocha.red) },
          BufferInactiveWARN = { bg = mocha.mantle, fg = blend(mocha.yellow) },
          BufferAlternateMod = { bg = '', fg = blend(mocha.yellow) },
          BufferInactiveMod = { bg = '', fg = blend(mocha.yellow) },
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
      -- nvimtree = true,
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
