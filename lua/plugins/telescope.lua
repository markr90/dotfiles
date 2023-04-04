local function fuzzy_find_in_buffer() -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
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
      { '<leader>fg', function() require('telescope.builtin').live_grep() end,   desc = 'Search in files for text' },
      {
        '<C-p>',
        function() require('telescope.builtin').find_files() end,
        desc = 'Search for files in project directory'
      },
      { '<leader>fb',  fuzzy_find_in_buffer,                                     desc = 'Fuzzy find in buffer' },
      { '<leader>fd', function() require('telescope.builtin').diagnostics() end, desc = 'Search diagnostics' },
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
