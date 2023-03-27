return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local treesj = require('treesj')
    treesj.setup({})
    vim.keymap.set('n', '<leader>m', treesj.toggle)
  end,
}
