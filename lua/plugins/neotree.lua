local opts = {
  filesystem = {
    follow_current_file = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_by_name = {
        'node_modules',
        '.git',
      },
    },
    window = {
      mappings = {
        ["<leader>st"] = function(state)
          local node = state.tree:get_node()
          if string.find(node.path, '.csproj') then
            vim.g['PROJECTSTARTUPPATH'] = node.path
            print('Startup path is now: ' .. vim.g['PROJECTSTARTUPPATH'])
          end
        end
      },
    },
  },
  window = {
    width = 35,
  },
}
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      vim.keymap.set('n', '<leader>ew', ':Neotree show focus<CR>')
      vim.keymap.set('n', '<leader>eq', ':Neotree close<CR>')
      require('neo-tree').setup(opts)
    end
  }
}
