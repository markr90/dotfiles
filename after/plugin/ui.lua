vim.opt.termguicolors = true

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  no_italic = true,
  integrations = {
    telescope = true,
    treesitter = true,
    cmp = true,
    gitsigns = true,
    native_lsp = {
      enabled = true,
    },
  }
})
vim.cmd.colorscheme "catppuccin-mocha"

require("bufferline").setup({
  options = {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    diagnostics = "nvim_lsp",
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diag_dict)
      local s = ""
      for e, n in pairs(diag_dict) do
        local sym = e == "error" and ''
          or (e == "warning" and '' or '')
        s = n .. sym .. s
      end
      return s
    end
  }
})

local colors = require('catppuccin.palettes').get_palette 'macchiato'

require('scrollbar').setup({
  handle = {
    text = " ",
    blend = 0,
    color = colors.surface2
  },
  marks = {
    Cursor = {
      text = "■"
    },
    Search = {
      color = "#ffffff"
    },
  }
})

require('gitsigns').setup()
require("scrollbar.handlers.gitsigns").setup()

require('lualine').setup {
  options = {
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_d = { 'diagnostics' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_d = { 'diagnostics' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
