local Hydra = require('hydra')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local Diff = {}

local function get_default_branch_name()
	local res = vim
		.system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true })
		:wait()
	return res.code == 0 and 'main' or 'master'
end

Diff.keymappings = {
    -- Be careful not to overlap with diagnostics severity keymappings.
    n = {
        d = { cmd '.DiffviewFileHistory --follow %', 'Line diff history' },

        h = { cmd 'DiffviewFileHistory', 'Repo diff history' },
        f = { cmd 'DiffviewFileHistory --follow %', 'File diff history' },

        s = { cmd 'DiffviewOpen', 'Repo diff (aka git Status)' },
        l = {
            l = { cmd('DiffviewOpen ' .. get_default_branch_name()), 'Diff local remote main' },
            L = { cmd('DiffviewOpen HEAD..origin/' .. get_default_branch_name()), 'Diff against remote origin/main' },
        },

        n = { cmd 'diffget', 'Diff get' },
        c = { cmd 'diffput', 'Diff put' },
    },

    x = {
        d = { "<Esc><Cmd>'<,'>DiffviewFileHistory --follow %<Cr>", 'Visual selection diff history' },
    },
}

return Diff
