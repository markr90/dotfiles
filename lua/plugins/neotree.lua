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
  },
  window = {
    width = 35,
    mappings = {
      ["<esc>"] = "close_window"
    }
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
      { "<leader>ew", "<cmd>Neotree focus float<cr>", desc = "Neotree show" },
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require('neo-tree').setup(opts)
    end,
  }
}
