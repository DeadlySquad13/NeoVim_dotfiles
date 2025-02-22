local Hydra = require('hydra')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd
local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings

---@param command (string)
local function tab(command)
    return cmd('tab' .. command)
end

local Tab = {}

Tab.mappings = {
    [keymappings.next_global] = {
        t = { tab 'next', 'Next Tab' },
    },
    [keymappings.previous_global] = {
        t = { tab 'previous', 'Previous Tab' },
    },
    [keymappings.create] = {
      t = { tab 'new', 'Create new Tab' }
    }
}

Tab.hydra = Hydra({
    name = 'Tabs',
    config = {
        hint = {
            float_opts = {
                style = 'rounded',
            },
            offset = -1
        }
    },
    mode = 'n',
    heads = {
        { keymappings.next,     tab 'next' },
        { keymappings.previous, tab 'previous' },
        { 'n',                  tab 'new' },
        { 'l',                  tab 'close' },
    }
})

return Tab
