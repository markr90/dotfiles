return {
  {
    'echasnovski/mini.bracketed',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local vscode = require('gehaktmolen.constants').vscode
      local conditional_bind = function(kb)
        return vscode and '' or kb
      end
      require('mini.bracketed').setup(
        {
          buffer     = { suffix = conditional_bind('b'), options = {} },
          comment    = { suffix = 'c', options = {} },
          conflict   = { suffix = 'x', options = {} },
          diagnostic = { suffix = conditional_bind('d'), options = {} },
          file       = { suffix = '', options = {} },
          indent     = { suffix = '', options = {} },
          jump       = { suffix = 'j', options = {} },
          location   = { suffix = 'l', options = {} },
          oldfile    = { suffix = '', options = {} },
          quickfix   = { suffix = 'q', options = {} },
          treesitter = { suffix = conditional_bind('t'), options = {} },
          undo       = { suffix = '', options = {} },
          window     = { suffix = conditional_bind('w'), options = {} },
          yank       = { suffix = '', options = {} },
        }
      )
    end,
  }
}
