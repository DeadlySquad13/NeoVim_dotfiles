return {
    'LukasPietzschmann/telescope-tabs',

    dependencies = { 'nvim-telescope/telescope.nvim' },

    opts = {},

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local telescope_is_available, telescope = prequire('telescope')
        local telescope_tabs_is_available, telescope_tabs = prequire('telescope-tabs')

        if not telescope_is_available and telescope_tabs_is_available then
            return
        end

        telescope.load_extension('telescope-tabs')
        telescope_tabs.setup(opts)
    end,
}
