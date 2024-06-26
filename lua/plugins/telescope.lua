local function fuzzy_find_in_current_buffer() -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end

local function fuzzy_find_in_open_buffers() -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({
    layout_config = { width = 0.5 },
    grep_open_files = true,
  }))
end

local function find_files()
 require('telescope.builtin').find_files()
end

return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup({
        pickers = {
          find_files = {
            find_command = {'rg', '--files', '--hidden', '-g', '!.git'},
          },
          live_grep = {
            additional_args = function(opts)
              return {'--hidden', '-g', '!.git'}
            end,
          },
        },
      })
    end,
    cmd = {
      'Telescope',
    },
    keys = {
      {
        '<C-f>',
        function() require('telescope.builtin').live_grep() end,
        desc = 'Search in files for text',
      },
      {
        '<C-p>',
        function() find_files() end,
        desc = 'Search for files in project directory'
      },
      {
        '<leader>ll',
        function() require('telescope.builtin').oldfiles() end,
        desc = 'Search recently opened files'
      },
      {
        '<leader>fB',
        fuzzy_find_in_current_buffer,
        desc = 'Fuzzy find in buffer',
      },
      {
        '<leader>fb',
        fuzzy_find_in_open_buffers,
        desc = 'Fuzzy find in open buffers',
      },
      {
        '<leader>fc',
        function() require('telescope.builtin').grep_string() end,
        desc = 'Find word under cursor',
      },
      {
        '<leader>fd',
        function() require('telescope.builtin').diagnostics() end,
        desc = 'Search diagnostics',
      },
    },
  },
}
