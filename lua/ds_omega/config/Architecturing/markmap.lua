return {
  "nixenjoyer/markmap.nvim",
  branch = "feat/markmap_cmd-in-config",
  -- Installed locally at kbn.
  -- build = "yarn global add markmap-cli",
  cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
  opts = {
    --  Setting an empty string "" here means: `<Current buffer path>.html`.
    --  Can be absolute path to folder.
    markmap_cmd = "yarn markmap",
    html_output = "",
    hide_toolbar = false,
    -- Stops markmap watch after N ms. Set it to 0 to disable the grace_period.
    grace_period = 6 * 60 * 1000
  },
  config = function(_, opts) require("markmap").setup(opts) end
}
