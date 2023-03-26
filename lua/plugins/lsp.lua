local servers = {
  tsserver = {},
  jsonls = {},
  omnisharp = {
    formattingOptions = {
      newLinesForBracesInTypes = true,
    }
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      format = {
        enable = true,
        defaultConfig = {
          indent_tyle = 'space',
          indent_size = '2',
          continuation_indent = "2",
        },
      },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
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
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>dn', vim.diagnostic.goto_next, '[D]iagnostic [N]ext')
  nmap('<leader>dp', vim.diagnostic.goto_prev, '[D]iagnostic [P]rev')
  nmap('<leader>dd', function() vim.diagnostic.open_float(nil, { focus = false }) end, 'Line [D]iagnostics')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.cmd [[set eol]]
        vim.lsp.buf.format()
      end,
    })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*" },
      command = [[%s/\s\+$//e]],
    })
  end
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local function lsp_setup()
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Setup mason so it can manage external tooling
  require('mason').setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end,
  }
  local signs = require('gehaktmolen.constants').signs

  vim.fn.sign_define("DiagnosticSignError",
    { text = signs.error, texthl = "DiagnosticSignError", numhl = 'DiagnosticSignError' })
  vim.fn.sign_define("DiagnosticSignWarn",
    { text = signs.error, texthl = "DiagnosticSignWarn", numhl = 'DiagnosticSignWarn' })
  vim.fn.sign_define("DiagnosticSignInfo",
    { text = signs.error, texthl = "DiagnosticSignInfo", numhl = 'DiagnosticSignInfo' })
  vim.fn.sign_define("DiagnosticSignHint",
    { text = signs.error, texthl = "DiagnosticSignHint", numhl = 'DiagnosticSignHint' })

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'single',
      source = 'always',
      header = '',
      prefix = '',
    },
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = lsp_setup,
  }
}
