local function lualine_setup()
  -- local onedarktheme = require('lualine.themes.onedark')
  -- local inactive_color = onedarktheme.normal.c.bg
  -- onedarktheme.inactive.a.bg = inactive_color
  -- onedarktheme.inactive.b.bg = inactive_color
  -- onedarktheme.inactive.c.bg = inactive_color
  require('lualine').setup({
    options = {
      -- theme = 'catppuccin',
      icons_enabled = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'neo-tree', 'NvimTree' },
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
  })
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = lualine_setup,
  }
}
