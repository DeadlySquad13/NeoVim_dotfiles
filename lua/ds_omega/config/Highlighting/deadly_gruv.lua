return {
  'DeadlySquad13/deadly-gruv.nvim',

  priority = 1000 - 1,
  lazy = false,

  -- See `dev.path` in lazy.setup 2nd param.
  dev = require("ds_omega.utils.os").is("Linux"),

  dependencies = 'rktjmp/lush.nvim',

  config = function()
    local colorschemas = require('ds_omega.config.theme')

    require('ds_omega.ds_omega_utils').load_coloscheme(
      colorschemas.COLORSCHEME_NAME,
      colorschemas.BACKUP_COLORSCHEME_NAME,
      colorschemas.FALLBACK_COLORSCHEME_NAME
    )
  end
}
