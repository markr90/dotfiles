return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    { '<leader>m', function() require('treesj').toggle() end, desc = 'Toggle tree code line join' },
  },
  config = function()
    require('treesj').setup({})
  end,
}
