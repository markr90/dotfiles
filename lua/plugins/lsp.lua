local servers = {
  tsserver = {},
  jsonls = {},
  angularls = {},
  rust_analyzer = {
    inlayHints = false,
  },
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
        on_attach = require('gehaktmolen.on-attach').on_attach,
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

  local _border = require('gehaktmolen.constants').border

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = _border
    }
  )

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = _border
    }
  )
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'joechrisellis/lsp-format-modifications.nvim',
    },
    config = lsp_setup,
  }
}
