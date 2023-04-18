return {
  {
    'vim-test/vim-test',
    cmd = {
      'TestNearest',
      'TestFile',
      'TestSuite',
      'TestLast',
      'TestVisit'
    },
    enabled = function()
      return not require('gehaktmolen.constants').isVscode()
    end,
  }
}
