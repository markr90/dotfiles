return {
  {
    'echasnovski/mini.bracketed',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('mini.bracketed').setup(
        {
          buffer     = { suffix = 'b', options = {} },
          comment    = { suffix = 'c', options = {} },
          conflict   = { suffix = 'x', options = {} },
          diagnostic = { suffix = 'd', options = {} },
          file       = { suffix = '', options = {} },
          indent     = { suffix = '', options = {} },
          jump       = { suffix = 'j', options = {} },
          location   = { suffix = 'l', options = {} },
          oldfile    = { suffix = '', options = {} },
          quickfix   = { suffix = 'q', options = {} },
          treesitter = { suffix = 't', options = {} },
          undo       = { suffix = '', options = {} },
          window     = { suffix = 'w', options = {} },
          yank       = { suffix = '', options = {} },
        }
      )
    end,
  }
}
