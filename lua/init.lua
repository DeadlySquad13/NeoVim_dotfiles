--requirement.
-- It will be added as a simple module pattern (either `path.lua` or
--`path/init.lua`).
---@param path (string) # Folder to add.
local function append_to_package_path(path)
  package.path = path .. '/?.lua;' .. path .. '/?/init.lua;' .. package.path
end

append_to_package_path(require('ds_omega.constants.env').NVIM_AFTER)
require('ds_omega.utils.global')
require('general_settings')
require('plugins')
require('ds_omega.commands')
require('ds_omega.autocommands')
-- REFACTOR: Make them as small plugins and setup using Lazy.
require('ds_omega.modules.choose_and_edit_configs').setup()
