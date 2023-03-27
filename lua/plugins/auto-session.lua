return {
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup({
        log_level = 'error',
        pre_save_cmds = {
          function()
            vim.cmd([[ Neotree close ]])
          end,
        },
        post_save_cmds = {
          function()
            vim.cmd([[ Neotree show ]])
          end,
        },
        post_restore_cmds = {
          function()
            vim.cmd([[ Neotree show ]])
          end,
        },
      })
    end,
  }
}
