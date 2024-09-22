local CONSTANTS = {}

CONSTANTS.transitive_catalizator = '.'

CONSTANTS.KEY = {
  C_forward_slash = '<c-_>',
  forward_slash = '/',
  backslash = [[\]],
}

local leader_left = 'r'
local leader_right = 'h'

CONSTANTS.keymappings = {
  leader_left = leader_left,
  leader_right = leader_right,

  inside = 'q',
  around = 'e',

  inside_additional = 'Q',
  around_additional = 'E',

  -- Mostly used for local keymappings: 
  -- - textobjects and navigation in buffer.
  -- - in specific modes.
  next = 'y',
  previous = '"',

  -- For global traversals between, for example: tabs, buffers, sessions and so
  -- on.
  next_global = ']',
  previous_global = '[',

  create = leader_right..'c',
}

-- About global and local keymappings: go to next buffer - global keymapping.
-- But if we're already in buffer mappings key branch or in a buffer
-- mode - go to next will be local in this context.

return CONSTANTS
