return {
  {
    'echasnovski/mini.jump',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    config = function()
      require('mini.jump').setup()
    end,
  }
}
