return {
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function()
      local opts = {
        -- symbol = "▏",
        symbol = "│",
        options = { try_as_border = true },
        draw = {
          animation = require('mini.indentscope').gen_animation.none(),
        },
      }
      require("mini.indentscope").setup(opts)
    end,
  },
}
