local choose_and_edit_target = require('ds_omega.modules.choose_and_edit_configs.choose_and_edit_target')

local M = {}

M.choose_and_edit_configs = function()
  local items = require('ds_omega.config.choose_and_edit_target')
  choose_and_edit_target(items)
end

M.setup = function()
  local create_user_command = require('ds_omega.utils.commands').create_user_command

  -- See `:h user-commands` and `:h nvim_create_user_command()`.
  create_user_command(
    'ChooseAndEditConfigs',
    M.choose_and_edit_configs,
    { nargs = 0 }
  )
end

return M
