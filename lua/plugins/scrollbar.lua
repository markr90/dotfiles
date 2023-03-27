return {
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
    },
    config = function()
      require('scrollbar').setup({
        handle = {
          text = " ",
          blend = 0,
          color = '#585b70'
        },
        marks = {
          Cursor = {
            text = "■"
          },
          Search = {
            color = "#ffffff"
          },
        }
      })
      require("scrollbar.handlers.search").setup({
        override_lens = function()
        end,
      })
      vim.cmd([[
        augroup scrollbar_search_hide
            autocmd!
            autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
        augroup END
    ]])
    end,
  }
}
