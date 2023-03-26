vim.g.mapleader = ' '
vim.keymap.set('n', '<SPACE>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<leader>ee', vim.cmd.Ex)
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true })
vim.keymap.set('n', '<leader>p', '"_dP', { noremap = true })
