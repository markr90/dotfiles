return {
  {
    'echasnovski/mini.cursorword',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile', },
    config = function()
      require('mini.cursorword').setup()
    end,
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  }
}
