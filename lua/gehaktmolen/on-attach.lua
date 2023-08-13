local M = {}

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
function FormatFunction()
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
end

local on_attach = function(client, bufnr)
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { noremap = true, buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', require("renamer").rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>dd', function() vim.diagnostic.open_float(nil, { focus = false }) end, 'Line [D]iagnostics')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>dh', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- eslint fix on save
  -- if client.name == 'eslint' then
  --   vim.api.nvim_create_autocmd('BufWritePre', {
  --     group = augroup,
  --     buffer = bufnr,
  --     callback = function()
  --       vim.cmd([[EslintFixAll]])
  --     end,
  --   })
  -- end

  vim.keymap.set('v', '<leader>fs', '<cmd>lua FormatFunction()<CR>=',
    { desc = 'Formats selected text with lsp and then indents' })
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


M.on_attach = on_attach

return M
