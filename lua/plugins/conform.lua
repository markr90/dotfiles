return {
    {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = { 'ConformInfo' },
        opts = {},
        config = function ()
            require('conform').setup({
                formatters_by_ft = {
                    markdown = {'prettier_markdown'},
                },
            })

            local markdown_formatter = vim.deepcopy(require("conform.formatters.prettierd"))
            require("conform.util").add_formatter_args(markdown_formatter, {
              "--prose-wrap=always",
              "--print-width=100",
            }, { append = false })
            require("conform").formatters.prettier_markdown = markdown_formatter

            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = "*",
              callback = function(args)
                require("conform").format({ bufnr = args.buf })
              end,
            })
        end,
    }
}
