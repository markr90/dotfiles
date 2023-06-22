return {
  {
    'rgroli/other.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('other-nvim').setup({
        mappings = {
          {
            pattern = "(.*).ts$",
            target = {
              {
                target = "%1.html",
                context = "html"
              },
              {
                target = "%1.scss",
                context = "scss"
              },
            }
          },
          {
            pattern = "(.*).html$",
            target = {
              {
                target = "%1.ts",
                context = "component"
              },
              {
                target = "%1.scss",
                context = "scss"
              },
            }
          },
          {
            pattern = "(.*).scss$",
            target = {
              {
                target = "%1.ts",
                context = "component"
              },
              {
                target = "%1.html",
                context = "html"
              },
            }
          },
        }
      })

      vim.keymap.set('n', '<A-o>', '<cmd>:Other<cr>', { noremap = true, silent = true })
      vim.keymap.set('n', '<A-i>', '<cmd>:Other scss<cr>', { noremap = true, silent = true })
    end,
  }
}
