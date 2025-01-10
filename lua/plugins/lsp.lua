local servers = {
    eslint = {},
    angularls = {},
    jsonls = {},
    gopls = {},
    pyright = {
        python = {
            analysis = { typeCheckingMode = "off" },
        },
    },
    clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            format = {
                enable = true,
                defaultConfig = {
                    indent_tyle = 'space',
                    indent_size = '4',
                    continuation_indent = "4",
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
    local menu_items = {
        nvim_lsp = "[LSP]",
        nvim_lsp_signature_help = "[f]",
        buffer = "[buf]",
        path = "[path]",
        vsnip = "[snip]",
    }

    local kind_icons = require('gehaktmolen.constants').lsp_kind_icons

    return {
        completion = {
            completeopt = "menu,menuone,noinsert,noselect",
        },
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                select = false,
            },
            ["<Tab>"] = cmp.mapping(function(fallback)
                -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                if cmp.visible() then
                    local entry = cmp.get_selected_entry()
                    if not entry then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        cmp.confirm()
                    end
                else
                    fallback()
                end
            end, { "i", "s", "c", }),
            ['<C-n>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-p>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        sources = {
            -- { name = 'copilot' },
            { name = 'nvim_lsp',               dup = 0 },
            { name = 'nvim_lsp_signature_help' },
            { name = "buffer",                 keyword_length = 5 },
            { name = "path" },
            { name = "vim_vsnip" },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                print(vim_item)
                vim_item.kind = kind_icons[vim_item.kind]
                vim_item.menu = menu_items[entry.source.name]
                return vim_item
            end,
        },
        experimental = {
            ghost_text = true,
        }
    }
end
--
local signs = require('gehaktmolen.constants').signs

vim.fn.sign_define("DiagnosticSignError",
    { text = signs.error, texthl = "DiagnosticSignError", numhl = 'DiagnosticSignError' })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = signs.warn, texthl = "DiagnosticSignWarn", numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = signs.info, texthl = "DiagnosticSignInfo", numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define("DiagnosticSignHint",
    { text = signs.hint, texthl = "DiagnosticSignHint", numhl = 'DiagnosticSignHint' })
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
    require('lspkind').init()
    -- require('copilot').setup({})
    -- require('copilot_cmp').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local cmp = require('cmp')
    cmp.setup(cmp_opt())
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
        ["clangd"] = function()
            require('lspconfig').clangd.setup {
                on_attach = require('gehaktmolen.on-attach').on_attach,
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--fallback-style=webkit",
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
            }
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
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'nvim-lua/plenary.nvim',
            'onsails/lspkind.nvim',
            -- 'github/copilot.vim',
            -- 'zbirenbaum/copilot.lua',
            -- 'zbirenbaum/copilot-cmp',
        },
        config = lsp_setup,
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = { 'Mason' },
    }
}
