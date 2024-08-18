return {
  'folke/which-key.nvim',
  enabled = true,
  version = "2.x",

  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 600
  end,

  opts = require('ds_omega.config.Ui.which_key.settings'),
  config = function(_, opts)
    local lmu = require('langmapper.utils')
    local view = require('which-key.view')
    local execute = view.execute

    -- wrap `execute()` and translate sequence back
    view.execute = function(prefix_i, mode, buf)
      -- Translate back to English characters
      local ru_prefix_i = lmu.translate_keycode(prefix_i, 'default', 'ru')
      execute(ru_prefix_i, mode, buf)

      -- local hdn_prefix_i = lmu.translate_keycode(prefix_i, 'default', 'hdn')
      -- execute(hdn_prefix_i, mode, buf)
    end

    require('which-key').setup(opts)

    local apply_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_keymappings

    local mappings = require('ds_omega.config.keymappings')

    for mode, mode_mappings in pairs(mappings) do
        apply_keymappings(mode, mode_mappings)
    end
  end
}
