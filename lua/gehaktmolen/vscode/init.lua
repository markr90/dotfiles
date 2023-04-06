local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

local function v_notify(cmd)
    return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
end

vim.g.mapleader = ' '
vim.keymap.set('n', '<SPACE>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<leader>ee', vim.cmd.Ex)
vim.keymap.set('n', '<Leader>gr', notify 'references-view.findReferences', { silent = true }) -- language references
vim.keymap.set('n', '<Leader>xd', notify 'workbench.actions.view.problems', { silent = true }) -- language diagnostics
vim.keymap.set('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
vim.keymap.set('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
vim.keymap.set('n', '<Leader>fm', notify 'editor.action.formatDocument', { silent = true })
vim.keymap.set('n', '<Leader>ca', notify 'editor.action.refactor', { silent = true }) -- language code actions

vim.keymap.set('n', '<Leader>gg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
vim.keymap.set('n', '<Leader>ew', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
vim.keymap.set('n', '<Leader>th', notify 'workbench.action.toggleAuxiliaryBar', { silent = true }) -- toggle docview (help page)
vim.keymap.set('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
vim.keymap.set('n', '<Leader>fc', notify 'workbench.action.showCommands', { silent = true }) -- find commands
vim.keymap.set('n', '<Leader>ff', notify 'workbench.action.quickOpen', { silent = true }) -- find files
vim.keymap.set('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window

vim.keymap.set('v', '<Leader>fm', v_notify 'editor.action.formatSelection', { silent = true })
vim.keymap.set('v', '<Leader>ca', v_notify 'editor.action.refactor', { silent = true })
vim.keymap.set('v', '<Leader>fc', v_notify 'workbench.action.showCommands', { silent = true })
