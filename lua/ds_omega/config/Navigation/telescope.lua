return {
 'nvim-telescope/telescope.nvim',
  dependencies = 'nvim-lua/plenary.nvim',

  opts = function()

    local actions = require('telescope.actions')

    local common_keymappings = {
      ['<C-d>'] = actions.delete_buffer,
      ['<C-s>'] = actions.select_horizontal,
    }

    local pickers = require('ds_omega.config.Editing.yanky.picker')()

    return {
      defaults = {
        -- Default configuration for telescope.
        mappings = {
          n = vim.tbl_extend('force', common_keymappings, {
            ['<c-d>'] = actions.delete_buffer,
          }),
          i = vim.tbl_extend('force', common_keymappings, {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ['<C-h>'] = 'which_key',
          }),
        }
      },

      pickers = {
        buffers = {
          layout_strategy = 'vertical',
          layout_config = {
            preview_height = 0.6,
          },
        },
      },

      extensions = {
        file_browser = require('ds_omega.config.Navigation.telescope_file_browser').opts(),
        undo = require('ds_omega.config.Editing.undo').opts(),
        --   Unfortunately, doesn't work. Should be set up in setup function of
        -- yanky.
        yank_history = pickers.telescope,
        agrolens = require('ds_omega.config.Navigation.agrolens').opts,
        advanced_git_search = require('ds_omega.config.Git.advanced_git_search').opts,
        bibtex = require('ds_omega.config.Navigation.telescope_bibtex').opts(),
      }
    }
  end,
}
