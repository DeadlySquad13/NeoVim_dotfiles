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
    "stevearc/dressing.nvim",                                  -- Recommended but not required. Better UI for pickers.
    "nvim-tree/nvim-web-devicons"                              -- Recommended but not required. Icons in discussion tree.
  },
  build = function() require("gitlab.server").build(true) end, -- Builds the Go binary

  opts = require('ds_omega.config.Git.gitlab.settings'),

  init = function()
    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')

    if not ds_omega_utils_is_available then
      return
    end

    ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Git.gitlab.keymappings'))
  end,

  config = function(_, opts)
    local gitlab_is_available, gitlab = require('ds_omega.ds_omega_utils').prequire_plugin('gitlab')
    if not gitlab_is_available then
      return
    end

    gitlab.setup(opts)
  end,
}
