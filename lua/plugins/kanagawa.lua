return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = false },
        functionStyle = { italic = false },
        keywordStyle = { italic = false},
        statementStyle = { italic = false, bold = false },
        typeStyle = { italic = false },
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        overrides = function(colors)
          return {
            ["@variable.builtin"] = { italic = false },
            -- IndentBlanklineChar = { fg = colors.theme.ui.bg_m2 },
            IndentBlanklineIndent1 = { fg = colors.theme.ui.bg_m3 },
            IndentBlanklineIndent2 = { fg = colors.theme.ui.bg_m2 },
            IndentBlanklineIndent3 = { fg = colors.theme.ui.bg_m1 },
            IndentBlanklineIndent4 = { fg = colors.theme.ui.bg },
            IndentBlanklineIndent5 = { fg = colors.theme.ui.bg_p1 },
            IndentBlanklineIndent6 = { fg = colors.theme.ui.bg_p2 },
            IndentBlanklineIndent7 = { fg = colors.theme.ui.bg_p3 },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              }
            }
          }
        }
      })
      vim.cmd([[colorscheme kanagawa]])
    end,
  }
}
