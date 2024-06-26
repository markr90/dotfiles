return {
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      -- 'catppuccin/nvim',
    },
    -- event = 'BufReadPost',
    config = function()
      local bufferline = require('bufferline')
      bufferline.setup({
        -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          diagnostics = 'nvim_lsp',
          style_preset = {
              bufferline.style_preset.no_italic,
              bufferline.style_preset.no_bold
          },
          diagnostics_indicator = function(_, _, diag, context)
            local icons = require('gehaktmolen.constants').signs
            local ret = (diag.error and icons.error .. " " .. diag.error .. " " or "")
            .. (diag.warning and icons.warn .. " " .. diag.warning or "")
            return vim.trim(ret)
          end,
        },
      })
      vim.keymap.set('n', '<C-n>', '<Cmd>BufferLinePick<CR>', { desc = 'Navigate to buffer' })
    end,
  }
}
