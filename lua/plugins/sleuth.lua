return {
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  }
}
