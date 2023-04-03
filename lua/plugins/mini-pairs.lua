return {
  {
    'echasnovski/mini.pairs',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    config = function()
      require('mini.pairs').setup()
    end,
  }
}
