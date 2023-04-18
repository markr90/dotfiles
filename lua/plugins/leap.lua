return {
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    config = function ()
      local leap = require('leap')
      leap.add_default_mappings()
      leap.opts.case_sensitive = false
    end,
  }
}