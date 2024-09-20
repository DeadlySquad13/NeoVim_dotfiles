local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local leader_right = CONSTANTS.keymappings.leader_right

return {
	"chrisgrieser/nvim-rip-substitute",
	cmd = "RipSubstitute",
	keys = {
		{
			leader_right .. "r",
			function() require("rip-substitute").sub() end,
			mode = { "n", "x" },
			desc = "ripgrep search & replace",
		},
	},
}
