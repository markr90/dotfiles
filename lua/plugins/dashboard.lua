return {
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup({
        theme = 'doom',
        config = {
          center = {
            {
              icon = ' ',
              desc = 'Load recent session',
              key = 's',
              action = 'SessLoad'
            },
            {
              icon = ' ',
              desc = 'Recent files',
              key = 'l',
              action = 'Telescope oldfiles'
            },
            {
              icon = ' ',
              desc = 'Find files',
              key = 'p',
              action = 'Telescope find_files'
            },
            {
              icon = ' ',
              desc = 'Browse',
              key = 'e',
              action = 'Neotree focus float'
            },
            {
              icon = ' ',
              desc = 'Search',
              key = 'f',
              action = 'Telescope live_grep'
            },
            {
              icon = ' ',
              desc = 'Open dotfiles',
              key = 'd',
              action = 'cd $HOME/AppData/Local/nvim | Telescope find_files'
            },
          },
        }
      })
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  }
}
