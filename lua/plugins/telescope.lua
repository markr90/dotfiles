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

return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup({})
    end,
    keys = {
      {
        '<leader>fg',
        function() require('telescope.builtin').live_grep() end,
        desc = 'Search in files for text',
      },
      {
        '<C-p>',
        function() require('telescope.builtin').find_files() end,
        desc = 'Search for files in project directory'
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
        '<leader>fd',
        function() require('telescope.builtin').diagnostics() end,
        desc = 'Search diagnostics',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          local bufferPath = vim.fn.expand('%:p')
          if vim.fn.isdirectory(bufferPath) ~= 0 then
            vim.api.nvim_buf_delete(0, { force = true })
            require('telescope.builtin').find_files()
          end
        end,
      })
    end,
  },
}
