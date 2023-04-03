local netcore_adapter_config = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' }
}

local netcore_config = {
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

vim.g.dotnet_get_startup_path = function()
  if vim.g['project_startup_path'] ~= nil then
    return vim.g['project_startup_path']
  else
    vim.g['project_startup_path'] = vim.fn.input('Path to project: ', vim.fn.getcwd(), 'file')
    return vim.g['project_startup_path']
  end
end

vim.g.dotnet_get_dll_path = function()
  local project_path = vim.g.dotnet_get_startup_path()
  local project_directory = project_path:match('(.*[/|\\])')
  if vim.g['project_dll_path'] == nil then
    local dll_path = vim.fn.input('path to dll: ', project_directory .. 'bin/Debug/', 'file');
    vim.g['project_dll_path'] = dll_path
  end
  return vim.g['project_dll_path']
end

vim.g.dotnet_build_project = function()
  local project_path = vim.g.dotnet_get_startup_path()
  local cmd = 'dotnet build -c Debug ' .. project_path .. ' > /dev/null'
  print('')
  print('Cmd to execute: ' .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    print('\nBuild: ✔️ ')
  else
    print('\nBuild: ❌ (code: ' .. f .. ')')
  end
end
--
return {
  {
    'mfussenegger/nvim-dap',
    keys = '<F5',
    config = function()
      local dap = require('dap')
      dap.adapters.coreclr = netcore_adapter_config

      dap.configurations.cs = netcore_config
      dap.configurations.fsharp = netcore_config

      vim.keymap.set('n', '<F5>', require('dap').continue, { noremap = true })
      vim.keymap.set('n', '<F10>', require('dap').step_over, { noremap = true })
      vim.keymap.set('n', '<F11>', require('dap').step_into, { noremap = true })
      vim.keymap.set('n', '<F12>', require('dap').step_out, { noremap = true })
      vim.keymap.set('n', '<leader>b', require('dap').toggle_breakpoint, { noremap = true })
      vim.keymap.set('n', '<leader>B',
        function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { noremap = true })
      vim.keymap.set('n', '<leader>lp',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { noremap = true })
      vim.keymap.set('n', '<leader>cb', require('dap').clear_breakpoints, { noremap = true })
      vim.api.nvim_create_user_command('Quitdebug', require('dap').terminate,
        { desc = 'Terminates the debugging session' })
    end,
  }
}
