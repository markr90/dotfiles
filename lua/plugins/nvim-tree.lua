local options = {
  filters = {
    dotfiles = false,
    exclude = {
      vim.fn.stdpath "config" .. "/lua/custom",
    },
    custom = {
      "^\\.git",
    }
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 35,
    hide_root_folder = true,
  },
  git = {
    enable = true,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",
    indent_markers = {
      enable = false,
    },
  },
}

local function open_nvim_tree()
  -- open the tree
  require("nvim-tree.api").tree.open()
end

return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup(options)
      vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = 'NvimTree*',
        callback = function()
          local view = require('nvim-tree.view')
          local is_visible = view.is_visible()

          local api = require('nvim-tree.api')
          if not is_visible then
            api.tree.open()
          end
        end,
      })
    end,
  }
}
