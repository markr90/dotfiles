return {
  {
    'RishabhRD/nvim-cheat.sh',
    dependencies = {
      'RishabhRD/popfix',
    },
    cmd = 'Cheat',
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  }
}
