if vim.g.vscode then
	require('gehaktmolen.vscode')
else
	require("gehaktmolen.remap")
	require("gehaktmolen.lazy")
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.softtabstop = 4
	vim.opt.expandtab = true
	vim.opt.fixeol = true
	vim.opt.termguicolors = true
	vim.cmd([[ set clipboard+=unnamedplus ]])
	vim.cmd [[
	  augroup highlight_yank
	  autocmd!
	  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
	  augroup END
	]]

	local border = require('gehaktmolen.constants').border
	vim.diagnostic.config({
	  virtual_text = true,
	  signs = true,
	  update_in_insert = false,
	  underline = true,
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
end
