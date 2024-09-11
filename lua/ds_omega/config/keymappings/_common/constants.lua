local CONSTANTS = {}

CONSTANTS.transitive_catalizator = '.'

CONSTANTS.KEY = {
  C_forward_slash = '<c-_>',
  forward_slash = '/',
  backslash = [[\]],
}

CONSTANTS.keymappings = {
  inside = 'q',
  around = 'e',

  inside_additional = 'Q',
  around_additional = 'E',

  -- Mostly used for textobjects and navigation in buffer.
  next = 'y',
  previous = '"',

  -- For global traversals between, for example: tabs, buffers, sessions and so
  -- on.
  next_global = ']',
  previous_global = '[',
}

return CONSTANTS
