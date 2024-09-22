return {
  'mg979/vim-visual-multi',

  branch = 'master',

  config = function()
    keymappings = require('ds_omega.config.Editing.visual_multi.keymappings')

    if keymappings then
      vim.g.VM_maps = keymappings
    end

    vim.g.VM_set_statusline = 0 -- disable VM's statusline updates to prevent clobbering
    vim.g.VM_silent_exit = 1    -- because the status line already tells me the mode
  end,
}
