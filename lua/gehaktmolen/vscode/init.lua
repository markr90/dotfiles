local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

local function v_notify(cmd)
    return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
end

vim.g.mapleader = ' '
vim.keymap.set('n', '<SPACE>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<leader>ee', notify 'workbench.action.focusSideBar', { silent = true })
vim.keymap.set('n', '<Leader>gr', notify 'references-view.findReferences', { silent = true }) -- language references
vim.keymap.set('n', '<Leader>dd', notify 'workbench.actions.view.problems', { silent = true }) -- language diagnostics
vim.keymap.set('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
vim.keymap.set('n', 'gi', notify 'editor.action.goToImplementation', { silent = true })
vim.keymap.set('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
vim.keymap.set('n', '<Leader>rf', notify 'editor.action.refactor', { silent = true })
vim.keymap.set('n', '<Leader>fm', notify 'editor.action.formatDocument', { silent = true })
vim.keymap.set('n', '<Leader>ca', notify 'editor.action.quickFix', { silent = true }) -- language code actions
vim.keymap.set('n', '[d', notify 'editor.action.marker.prev', { silent = true, noremap = true })
vim.keymap.set('n', ']d', notify 'editor.action.marker.next', { silent = true, noremap = true })

vim.keymap.set('n', '<Leader>fg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
vim.keymap.set('n', '<Leader>ew', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
vim.keymap.set('n', '<Leader>ff', notify 'workbench.action.quickOpen', { silent = true }) -- find files
vim.keymap.set('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window

vim.keymap.set('v', '<Leader>fm', v_notify 'editor.action.formatSelection', { silent = true })
vim.keymap.set('v', '<Leader>rf', v_notify 'editor.action.refactor', { silent = true })

vim.keymap.set('n', '<Leader>gb', notify 'gitlens.toggleLineBlame', { silent = true })

vim.keymap.set('n', '<C-j>', '<Cmd>Tabprevious<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<C-k>', '<Cmd>Tabnext<CR>', { silent = true, noremap = true })

vim.keymap.set('v', '<leader>p', '"_dP', { noremap = true, desc = 'Paste without clearing register' })
vim.keymap.set('n', '<leader>wp', 'viw"_dP', { noremap = true, desc = 'Paste and replace word' })
vim.keymap.set('n', '<leader>nh', vim.cmd.noh, { noremap = true, desc = 'Remove highlights' })

vim.keymap.set('n', '<leader>b', notify 'editor.debug.action.toggleBreakpoint', { noremap = true, silent = true })

vim.cmd([[ set clipboard+=unnamedplus ]])
vim.cmd [[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  augroup END
]]

vim.api.nvim_create_user_command('DeleteBreakpoints', function(_)
  notify 'workbench.debug.viewlet.action.removeAllBreakpoints'
end, { desc = 'Delete all breakpoints' })

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
