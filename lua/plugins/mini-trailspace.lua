return {
  {
    "echasnovski/mini.trailspace",
    version = "*",
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require("mini.trailspace").setup()
      vim.api.nvim_create_user_command('TrimWhitespace', function(_)
        vim.cmd([[lua MiniTrailspace.trim()]])
      end, { desc = 'Trim trailing whitespace' })
    end,
  }
}
