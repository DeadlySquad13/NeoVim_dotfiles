---@class Module
local TextObjects = {}

TextObjects.plugins = {
  ['textobjects'] = {
    'kana/vim-textobj-user',
  },

  ['word_column'] = {
    'coderifous/textobj-word-column.vim',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['indented_paragraph'] = {
    'pianohacker/vim-textobj-indented-paragraph',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['indent'] = {
    'kana/vim-textobj-indent',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['hydrogen'] = {
    'GCBallesteros/vim-textobj-hydrogen',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['word'] = {
    'chaoren/vim-wordmotion',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },
}

return TextObjects
