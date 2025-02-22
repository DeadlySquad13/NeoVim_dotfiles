local Hydra = require('hydra')

local prequire = require('ds_omega.utils').prequire

local utils_is_available, utils = prequire('ds_omega.config.keymappings._common.utils')

if not utils_is_available then
  return
end

local cmd = utils.cmd

local CONSTANTS = require("ds_omega.config.keymappings._common.constants")
local keymappings, transitive_catalizator = CONSTANTS.keymappings, CONSTANTS.transitive_catalizator

---@param command (string)
local function qf(command)
    return cmd('c' .. command)
end

local QuickfixList = {}

QuickfixList.hydra = Hydra({
    name = 'Quickfix list',
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
        { keymappings.next,     qf 'next' },
        { keymappings.previous, qf 'previous' },
        { '[',                  qf 'old' },
        { ']',                  qf 'newer' },
    }
})

QuickfixList.keymappings = {
    name = "Quickfix list",

    [transitive_catalizator] = { function()
        require('ds_omega.config.keymappings.quickfix_list').hydra
            :activate()
    end, 'Activate quickfix list mode' },
}

local prequire = require('ds_omega.utils').prequire

local quickfix_list_utils_is_available, quickfix_list_utils = prequire('ds_omega.utils.quickfix_list')

if quickfix_list_utils_is_available and quickfix_list_utils then
    QuickfixList.keymappings = vim.tbl_extend("error", QuickfixList.keymappings, {
        q = { quickfix_list_utils.toggle_quickfix, "Toggle quickfix list" },
    })
end

-- TODO:Couldn't get `is_loaded` working. Need to add another way. For example,
-- in plugin module.
QuickfixList.keymappings = vim.tbl_extend("error", QuickfixList.keymappings, {
    m = {
        name = 'Marks',

        m = {
            cmd 'MarksQFListAll',
            'Send all marks to quickfix list '
        },
        b = {
            cmd 'MarksListBuf',
            'Send marks in current buffer to local quickfix list '
        },
        g = {
            cmd 'MarksQFListGlobal',
            'Send global marks to quickfix list '
        },
    },
    M = {
        cmd 'BookmarksQFListAll',
        'Send bookmarks of all types to quickfix list '
    }
})

return QuickfixList
