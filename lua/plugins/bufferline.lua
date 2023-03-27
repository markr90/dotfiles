local function setup_bufferline()
  local signs = require('gehaktmolen.constants').signs
  require('bufferline').setup({
    options = {
      highlights = require("catppuccin.groups.integrations.bufferline").get({}),
      diagnostics = "nvim_lsp",
      ---@diagnostic disable-next-line: unused-local
      diagnostics_indicator = function(count, level, diag_dict)
        local s = ""
        for e, n in pairs(diag_dict) do
          local sym = e == "error" and signs.error
            or (e == "warning" and signs.warn or signs.info)
          s = n .. sym .. s
        end
        return s
      end
    }
  })
end

return {
  {
    'akinsho/bufferline.nvim',
    priority = 2000,
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin/nvim',
    },
    config = setup_bufferline,
  }
}
