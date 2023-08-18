return {
  'karb94/neoscroll.nvim',
  enabled = false,

  opts = {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {
      '<C-u>',
      '<C-d>',
      '<C-b>',
      '<C-f>',
      '<C-y>',
      '<C-e>',
      'zt',
      'zz',
      'zb',
    },
    hide_cursor = true,            -- Hide cursor while scrolling
    stop_eof = true,               -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,     -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true,   -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = 'quadratic', -- Default easing function
    pre_hook = nil,                -- Function to run before the scrolling animation starts
    post_hook = nil,               -- Function to run after the scrolling animation ends
    performance_mode = false,      -- Disable "Performance Mode" on all buffers.
  },

  config = function(_, opts)
    require('neoscroll').setup(opts)

    local prequire = require('ds_omega.utils').prequire
    local is_neoscroll_config_available, neoscroll_config = prequire('neoscroll.config')
    if not is_neoscroll_config_available then
      return
    end

    -- Syntax: `[keys] = {function, {function arguments}}`.
    local scroll_mappings = {
      -- Use the "sine" easing function.
      ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '250', [['sine']] } },
      ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '250', [['sine']] } },
      -- Use the "circular" easing function.
      ['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '450', [['circular']] } },
      ['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450', [['circular']] } },
      -- Pass "nil" to disable the easing animation (constant scrolling speed).
      ['<C-y>'] = { 'scroll', { '-0.10', 'false', '100', nil } },
      ['<C-e>'] = { 'scroll', { '0.10', 'false', '100', nil } },
      -- When no easing function is provided the default easing function (in this case "quadratic") will be used.
      ['zt']    = { 'zt', { '300' } },
      ['zz']    = { 'zz', { '300' } },
      ['zb']    = { 'zb', { '300' } },
    }

    neoscroll_config.set_mappings(scroll_mappings)
  end,
}
