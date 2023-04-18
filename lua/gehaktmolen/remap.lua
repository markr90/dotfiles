vim.g.mapleader = ' '
vim.keymap.set('n', '<SPACE>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<leader>ee', vim.cmd.Ex, { desc = 'Open Explore' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, desc = 'Go down half a page' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, desc = 'Go up half a page'})
vim.keymap.set('n', 'n', 'nzz', { noremap = true, desc = 'Find next' })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true, desc = 'Find previous' })
vim.keymap.set('v', '<leader>p', '"_dP', { noremap = true, desc = 'Paste without clearing register' })
vim.keymap.set('n', '<leader>wp', 'viw"_dP', { noremap = true, desc = 'Paste and replace word' })
vim.keymap.set('n', '<leader>nh', vim.cmd.noh, { noremap = true, desc = 'Remove highlights' })
vim.keymap.set('n', '<C-j>', '<Cmd>bp<CR>', { silent = true, noremap = true, desc = 'Go to previous buffer' })
vim.keymap.set('n', '<C-k>', '<Cmd>bn<CR>', { silent = true, noremap = true, desc = 'Go to next buffer' })
