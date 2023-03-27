local function telescope_setup()
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<C-p>', builtin.find_files, { noremap = true, desc = 'Search for files in project directory' })
  vim.keymap.set('n', '<leader>gg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })
  vim.keymap.set('n', '<leader>ds', builtin.diagnostics, {})
  -- vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
end

return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = telescope_setup,
  },
}
