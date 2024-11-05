-- Get token by going to url:
-- https://gitlab.example.com/-/user_settings/personal_access_tokens?name=Work__apakalo%40creamsoda%25Review_token&scopes=api,read_api,read_user,read_repository,write_repository
-- Change `gitlab.example.com` to desired host, for example, to `gitlab.com` for default. It wiil prefil all necessary fields, you only need to change expiration
-- date (leave it blank to get maximum date - ~1 year).
return {
    "harrisoncramer/gitlab.nvim",

    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "stevearc/dressing.nvim",                                -- Recommended but not required. Better UI for pickers.
        "nvim-tree/nvim-web-devicons"                            -- Recommended but not required. Icons in discussion tree.
    },
    build = function() require("gitlab.server").build(true) end, -- Builds the Go binary

    config = function(_, opts)
        require("gitlab").setup(opts)
    end,
}
