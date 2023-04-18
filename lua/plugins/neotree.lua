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
    hijack_netrw_behavior = 'open_current',
    window = {
      mappings = {
        ["<leader>zs"] = function(state)
          local node = state.tree:get_node()
          if string.find(node.path, '.csproj') then
            if (vim.g['project_startup_path'] ~= node.path) then
              vim.g['project_dll_path'] = nil
            end
            vim.g['project_startup_path'] = node.path
            print('Startup path is now: ' .. vim.g['project_startup_path'])
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
    keys = {
      { "<leader>ew", "<cmd>Neotree show focus<cr>", desc = "Neotree show" },
      { "<leader>eq", "<cmd>Neotree close<cr>",      desc = "Neotree hide" },
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require('neo-tree').setup(opts)
    end,
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  }
}
