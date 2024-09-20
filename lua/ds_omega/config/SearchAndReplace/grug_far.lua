return {
	'MagicDuck/grug-far.nvim',

	opts = {
		engine = 'astgrep',
	},

	config = function(_, opts)
	    require('grug-far').setup(opts)
	end,
}
