local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "C:/Users/MarkRaaijmakers/AppData/Local/nvim-data/mason/packages/omnisharp/OmniSharp.exe"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
local servers = {
  tsserver = {},
  eslint = {},
  jsonls = {},
  rust_analyzer = {
    inlayHints = false,
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

local function cmp_opt()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  return {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_signature_help' },
    },
  }
end
--
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

local function lsp_setup()
  require('renamer').setup({})
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local cmp = require('cmp')
  cmp.setup(cmp_opt())
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- snippets
  local ls = require('luasnip')
  ls.config.set_config({
    region_check_events = "InsertEnter",
    delete_check_events = "TextChanged,InsertLeave",
  })
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = {
      './snippets'
    }
  })

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
    ["omnisharp"] = function()
      require('lspconfig').omnisharp.setup({
        capabilities = capabilities,
        on_attach = require('gehaktmolen.on-attach').on_attach,
        settings = {},
        handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
      })
    end,
  }
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'joechrisellis/lsp-format-modifications.nvim',
      'Hoffs/omnisharp-extended-lsp.nvim',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'nvim-lua/plenary.nvim',
      'filipdutescu/renamer.nvim',
    },
    config = lsp_setup,
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'Mason' },
  }
}
