return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    config = function()
      require("scrollbar.handlers.gitsigns").setup()
    end
  }
}
