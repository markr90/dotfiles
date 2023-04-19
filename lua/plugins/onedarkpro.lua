local function setup_theme()
  local bg_new = '#181a20'
  local helpers = require('onedarkpro.helpers')
  require('onedarkpro').setup({
    colors = {
      onedark = {
        bg = bg_new,
      },
    },
  })

  local highlight_cursor = helpers.lighten(bg_new, 5)

  vim.cmd('hi MiniCursorwordCurrent guibg=' .. highlight_cursor .. ' gui=none')
  vim.cmd('hi MiniCursorword guibg=' .. highlight_cursor .. ' gui=none')

  vim.cmd('colorscheme onedark')
end

return {
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    config = setup_theme,
  }
}
