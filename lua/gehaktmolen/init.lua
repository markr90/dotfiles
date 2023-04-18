if vim.g.vscode then
  require('gehaktmolen.vscode')
else
  require('gehaktmolen.remap')
  require('gehaktmolen.nvim-init')
end

require('gehaktmolen.lazy')
