return {
  'okuuva/auto-save.nvim',

  opts = require('ds_omega.config.Editing.auto_save.settings'),

  config = function(_, opts)
    local keymappings = require('ds_omega.config.Editing.auto_save.keymappings')
    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(keymappings)

    require('auto-save').setup(opts)

    local utils = require('ds_omega.utils')
    local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

    local AutoSave = create_augroup('auto-save', { clear = true })

    local format_buf_name = require('ds_omega.config.utils').format_buf_name;

    create_autocmd({ 'User' }, {
      pattern = 'AutoSaveWritePost',
      group = AutoSave,
      desc = 'Show info message after auto-saving',
      callback = function(opts)
        if opts.data.saved_buffer ~= nil then
          local buf_name = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
          vim.notify('AutoSave: saved ' .. format_buf_name({ buf_name = buf_name }) .. ' at ' .. vim.fn.strftime('%H:%M:%S'),
            vim.log.levels.INFO)
        end
      end,
    })

    create_autocmd({ 'User' }, {
        pattern = 'AutoSaveEnable',
        group = AutoSave,
        desc = 'Show info message on enabling auto-save feature',
        callback = function()
            vim.notify('AutoSave enabled', vim.log.levels.INFO)
        end,
    })

    create_autocmd({ 'User' }, {
        pattern = 'AutoSaveDisable',
        group = AutoSave,
        desc = 'Show info message on disabling auto-save feature',
        callback = function()
            vim.notify('AutoSave disabled', vim.log.levels.INFO)
        end,
    })
  end,
}
