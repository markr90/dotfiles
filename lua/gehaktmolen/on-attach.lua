local M = {}

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- if vim.lsp.formatexpr then
  --   vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
  -- end
  -- if vim.lsp.tagfunc then
  --   vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  -- end
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { noremap = true, buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>dd', function() vim.diagnostic.open_float(nil, { focus = false }) end, 'Line [D]iagnostics')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('[d', vim.diagnostic.goto_prev, 'Goto prev diagnostic')
  nmap(']d', vim.diagnostic.goto_next, 'Goto next diagnostic')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>dh', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  vim.keymap.set('v', '<leader>fs', '<cmd>lua FormatFunction()<CR>=',
    { desc = 'Formats selected text with lsp and then indents' })
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


M.on_attach = on_attach

return M
