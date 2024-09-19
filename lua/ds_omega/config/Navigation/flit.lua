return {
  'ggandor/flit.nvim',
  dependencies = 'leap.nvim',

  opts = function()
    local leap_settings = require('ds_omega.config.Navigation.leap.settings')

    return {
      keys = {
        -- Rationale: `f` in most cases used for movement so it won't be that
        -- bad if it's on the same hand as actions.
        f = 'w', F = 'W',
        t = 'k', T = 'K',
      },
      labeled_modes = 'vo',
      multiline = false,
      opts = {
        safe_labels = leap_settings.safe_labels,
      }
    }
  end,

  config = true,
}
