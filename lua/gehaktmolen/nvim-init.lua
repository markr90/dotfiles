  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.softtabstop = 4
  vim.opt.expandtab = true
  vim.opt.fixeol = true
  vim.opt.termguicolors = true
  vim.opt.hidden = true
  vim.opt.signcolumn = 'yes'
  vim.cmd([[ set clipboard+=unnamedplus ]])
  vim.cmd [[
	  augroup highlight_yank
	  autocmd!
	  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
	  augroup END
	]]

  local border = require('gehaktmolen.constants').border
  vim.diagnostic.config({
    virtual_text = {
      severity = { min = vim.diagnostic.severity.WARN }
    },
    underline = {
      severity = { min = vim.diagnostic.severity.HINT }
    },
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = border,
      source = 'always',
      header = '',
      prefix = '',
    },
  })

vim.cmd([[set tabstop=4]])
