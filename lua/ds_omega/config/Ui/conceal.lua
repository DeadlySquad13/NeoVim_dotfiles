return {
  'Jxstxs/conceal.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  opts = {
      --[[ ['language'] = {
          enabled = bool,
          ['keyword'] = {
              enabled     = bool,
              conceal     = string,
              highlight   = string
          }
      } ]]
      ['lua'] = {
        ['local'] = {
          enabled = false, -- to disable concealing for 'local'
        },
        ['return'] = {
          enabled = false,
        },
        ['for'] = {
          highlight = 'keyword' -- to set the Highlight group to '@keyword'
        },

        ['then'] = {
          conceal = '{'
        },
        ['end'] = {
          conceal = '}'
        },
      },
      ['language'] = {
        enabled = false -- to disable the whole language
      }
  },

  config = true,
}
