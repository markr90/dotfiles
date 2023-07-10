vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[set ff=dos]],
  desc = 'Set file format to dos',
})
