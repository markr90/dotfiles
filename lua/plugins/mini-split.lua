return {
  {
    'echasnovski/mini.splitjoin',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    config = function()
      require('mini.splitjoin').setup()
    end,
  }
}
