return {
  {
    'echasnovski/mini.cursorword',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile', },
    config = function()
      require('mini.cursorword').setup()
    end,
  }
}
