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
vim.keymap.set('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
vim.keymap.set('n', '<Leader>rf', notify 'editor.action.refactor', { silent = true })
vim.keymap.set('n', '<Leader>fm', notify 'editor.action.formatDocument', { silent = true })
vim.keymap.set('n', '<Leader>ca', notify 'editor.action.quickFix', { silent = true }) -- language code actions
vim.keymap.set('n', '[d', notify 'editor.action.marker.prev', { silent = true, noremap = true })
vim.keymap.set('n', ']d', notify 'editor.action.marker.next', { silent = true, noremap = true })

vim.keymap.set('n', '<Leader>fg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
vim.keymap.set('n', '<Leader>ew', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
vim.keymap.set('n', '<Leader>fc', notify 'workbench.action.showCommands', { silent = true }) -- find commands
vim.keymap.set('n', '<Leader>ff', notify 'workbench.action.quickOpen', { silent = true }) -- find files
vim.keymap.set('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window

vim.keymap.set('v', '<Leader>fm', v_notify 'editor.action.formatSelection', { silent = true })
vim.keymap.set('v', '<Leader>rf', v_notify 'editor.action.refactor', { silent = true })
vim.keymap.set('v', '<Leader>fc', v_notify 'workbench.action.showCommands', { silent = true })

vim.keymap.set('n', '<Leader>gb', notify 'gitlens.toggleLineBlame', { silent = true })

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
