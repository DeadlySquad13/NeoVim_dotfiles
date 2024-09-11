local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings
local prequire = require('ds_omega.utils').prequire
local cmd = require('ds_omega.config.keymappings._common.utils').cmd

---@param command (string)
local function Drawer(command)
    return cmd('Drawer' .. command)
end

local cabinet_is_available, cabinet = prequire('cabinet')

if not cabinet_is_available then
  return
end

return {
  n = {
    [keymappings.next_global] = {
      c = { cabinet.drawer_next, 'Next drawer' }
    },
    [keymappings.previous_global] = {
      c = { cabinet.drawer_previous, 'Previous drawer' }
    },
    ['<Leader>c'] = {
      n = { Drawer 'New', 'Create New drawer' }
    }
  }
}
