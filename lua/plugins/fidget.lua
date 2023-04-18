return {
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({})
    end,
    event = 'LspAttach',
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  }
}
