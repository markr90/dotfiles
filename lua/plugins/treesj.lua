return {
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<leader>tj', function() require('treesj').toggle() end, desc = 'Toggle tree code line join' },
    },
    config = function()
      require('treesj').setup({})
    end,
  }
}
