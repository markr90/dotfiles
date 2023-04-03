return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require("scrollbar.handlers.gitsigns").setup()
    end
  }
}
