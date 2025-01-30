return {
  'debugloop/telescope-undo.nvim',

  dependencies = 'nvim-telescope/telescope.nvim',

  opts = function()
    local undo_actions = require("telescope-undo.actions")

    return {
      -- use_custom_command = { 'cmd.exe', '/c', [[echo $DIFF | delta]]}, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      use_custom_command = { 'pwsh.exe', '-NoProfile', '-Command', 'echo "$DIFF" | delta'}, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = true, -- Available only with delta.
      layout_strategy = 'vertical',
      layout_config = {
        preview_height = 0.8,
      },

      vim_diff_opts = { ctxlen = vim.o.scrolloff },
      entry_format = 'state #$ID, $STAT, $TIME',

      mappings = {
        i = {
          -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
          -- you want to replicate these defaults and use the following actions. This means
          -- installing as a dependency of telescope in it's `requirements` and loading this
          -- extension from there instead of having the separate plugin definition as outlined
          -- above.
          ['<C-y>'] = undo_actions.yank_additions,
          -- ['<C-y>'] = undo_actions.yank_deletions,
          ['<Cr>'] = undo_actions.restore,
        },
      },
    }
  end,

  config = function()
      local prequire = require('ds_omega.utils').prequire

      local telescope_is_available, telescope = prequire('telescope')

      if not telescope_is_available then
        return 
      end

      telescope.load_extension('undo')
  end,
}
