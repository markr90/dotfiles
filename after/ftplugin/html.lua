vim.cmd([[set ff=unix]])

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
  desc = 'Remove spaces at end of line',
})
