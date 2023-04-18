local opts = {
  -- lazy.nvim can automatically call setup for you. just put your options here:
  -- insert_at_start = true,
  -- animation = true,
  -- …etc
  animation = false,
  minimum_padding = 1,
  maximum_padding = 1,
  insert_at_end = true,
  icons = {
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = require('gehaktmolen.constants').signs.error .. ' ' },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = require('gehaktmolen.constants').signs.warn .. ' ' },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = false },
    },
  },
}

return {
  {
    'romgrk/barbar.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('barbar').setup(opts)
      vim.keymap.set('n', '<C-n>', '<Cmd>BufferPick<CR>', { desc = 'Navigate to buffer' })
    end,
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  },
}
