local function store_tree_in_global_state()
  local manager = require("neo-tree.sources.manager")
  local view = require('neo-tree.ui.renderer')
  local is_open = view.tree_is_visible(manager.get_state('filesystem')) and 1 or 0
  vim.g['ISTREEOPEN'] = is_open
end

local function restore_tree_from_global_state()
  if vim.g['ISTREEOPEN'] == 1 then
    require('neo-tree.sources.manager').show('filesystem')
  end
end
return {
  {
    'Shatur/neovim-session-manager',
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
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = config_group,
        callback = function()
          if vim.bo.filetype ~= 'git'
            and vim.bo.filetype ~= 'gitcommit'
          then
            session_manager.autosave_session()
          end
        end
      })
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
        vim.cmd([[SessionManager load_last_session]])
      end, { desc = 'Loads current session' })
      vim.api.nvim_create_user_command('SessDelete', function(_)
        vim.cmd([[SessionManager delete_session]])
      end, { desc = 'Deletes a session' })
    end,
  }
}
