return {
  signs = {
    error = '',
    warn = '',
    info = '',
    hint = '󰌶',
  },
  border = 'single',
  isWindows = function()
    return (vim.fn.has('win32') or vim.fn.has('win64')) == 1
  end,
}
