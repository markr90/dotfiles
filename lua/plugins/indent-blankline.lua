return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      },
      indent = {
        char = "│",
      },
      scope = {
        enabled = false,
      },
      whitespace = {
        remove_blankline_trail = false,
      },
    },
  },
}
