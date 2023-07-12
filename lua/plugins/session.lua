return {
  {
    'Shatur/neovim-session-manager',
    cmd = {
      'SessSave',
      'SessLoad',
      'SessDelete',
      'SessionLoadPre',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local session_manager = require('session_manager')
      session_manager.setup({
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
        autosave_only_in_session = true,
      })
      local config_group = vim.api.nvim_create_augroup('session-config-group', {})
      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = "SessionSavePre",
        group = config_group,
        callback = function()
          require('neo-tree.sources.manager').close('filesystem')
        end,
      })
      vim.api.nvim_create_user_command('SessSave', function(_)
        vim.cmd([[SessionManager save_current_session]])
      end, { desc = 'Saves current session' })
      vim.api.nvim_create_user_command('SessLoad', function(_)
        require('session_manager').load_current_dir_session()
      end, { desc = 'Loads current session' })
      vim.api.nvim_create_user_command('SessDelete', function(_)
        vim.cmd([[SessionManager delete_session]])
      end, { desc = 'Deletes a session' })
    end,
    -- init = function()
    --   vim.api.nvim_create_autocmd('VimEnter', {
    --     callback = function()
    --       if vim.fn.argc() == 0 then
    --         require('session_manager').load_current_dir_session()
    --       end
    --     end
    --   })
    -- end,
  }
}
