return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' }
      }

      vim.g.dotnet_build_project = function()
        local default_path = vim.fn.getcwd() .. '/'
        if vim.g['dotnet_last_proj_path'] ~= nil then
          default_path = vim.g['dotnet_last_proj_path']
        end
        local path = vim.fn.input('Path to your *proj file', default_path, 'file')
        vim.g['dotnet_last_proj_path'] = path
        local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
        print('')
        print('Cmd to execute: ' .. cmd)
        local f = os.execute(cmd)
        if f == 0 then
          print('\nBuild: ✔️ ')
        else
          print('\nBuild: ❌ (code: ' .. f .. ')')
        end
      end

      vim.g.dotnet_get_dll_path = function()
        local request = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end

        if vim.g['dotnet_last_dll_path'] == nil then
          vim.g['dotnet_last_dll_path'] = request()
        else
          if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
          end
        end
        return vim.g['dotnet_last_dll_path']
      end

      local config = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          console = "integratedTerminal",
          program = function()
            if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
              vim.g.dotnet_build_project()
            end
            return vim.g.dotnet_get_dll_path()
          end,
        },
      }

      dap.configurations.cs = config
      dap.configurations.fsharp = config
      vim.keymap.set('n', '<leader>zs', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end, {})
      vim.cmd([[
        nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
        nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
        nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
        nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
        nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
        nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
        nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
        nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
        nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
      ]])
    end,
  }
}
