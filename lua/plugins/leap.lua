return {
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    config = function ()
      require('leap').add_default_mappings()
    end,
  }
}
