return {
  {
    'm4xshen/hardtime.nvim',
    config = function()
      require('hardtime').setup({
        disable_mouse = false,
        max_count = 3,
        allow_different_key = true,
        help = false,
        disabled_filetypes = { "neo-tree", "help", "mason" },
      })
    end,
  }
}
