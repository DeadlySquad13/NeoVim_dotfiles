return {
  "smilhey/cabinet.nvim",

  config = function()
    local cabinet = require("cabinet")
    cabinet:setup()

    vim.api.nvim_create_autocmd("User", {
      nested = true,
      pattern = "DrawAdd",
      callback = function(event)
        local new_drawer_name = event.data
        cabinet.drawer_select(new_drawer_name)
      end,
    })

    local keymappings = require('ds_omega.config.ProjectManagement.cabinet.keymappings')
    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(keymappings)

  end
}
