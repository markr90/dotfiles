return {
  {
    'tpope/vim-fugitive',
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  }
}
