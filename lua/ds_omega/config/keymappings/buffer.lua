local Hydra = require('hydra')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings

local common_keymappings = {
    -- Navigation.
    h = { cmd 'BufferLineCyclePrev', 'Previous buffer' },
    l = { cmd 'BufferLineCycleNext', 'Next buffer' },
    [keymappings.previous] = { cmd 'BufferLineCyclePrev', 'Previous buffer' },
    [keymappings.next] = { cmd 'BufferLineCycleNext', 'Next buffer' },
    -- Moving buffers.
    H = { cmd 'BufferLineMovePrev', 'Move left' },
    L = { cmd 'BufferLineMoveNext', 'Move right' },
    P = { cmd 'BufferLineTogglePin', 'Toggle Pin' },
    -- Deletes buffer without closing vim if it was in the only window.
    d = { cmd 'Bdelete', 'Delete' },
    D = { cmd '%bdelete', 'Delete' },
    z = { cmd '%bdelete|edit#', 'Delete all buffer except for current one' },
    --see the [lua api](https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline.lua)
    --p = { function() bufferline.pick_buffer() end, 'Pick' },
    -- Picking.
    p = { function() vim.cmd('BufferLinePick') end, 'Pick' },
    -- Sorting.
    s = { cmd 'BufferLineSortByRelativeDirectory', 'Sort by relative directory' },
}

local function transform_to_hydra(key)
  local keymapping = common_keymappings[key]

  return { key, keymapping[1], { desc = keymapping[2] } }
end

local buffer_hydra = Hydra({
        name = 'Buffer',
        heads = vim.tbl_extend('force', vim.tbl_map(transform_to_hydra, vim.tbl_keys(common_keymappings)), {
            { 'p',     function() vim.cmd('BufferLinePick') end, { desc = 'Pick' } },

            { '<Esc>', nil,                                      { exit = true } }
        }),
    })

--- Activate only when there're multiple buffers.
local function activate_buffer_hydra()
  if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
    buffer_hydra:activate()
  end
end

return {
    vim.tbl_extend('error', common_keymappings, {
        name = 'Buffer',
        [require('ds_omega.config.keymappings._common.constants').transitive_catalizator] = {
            activate_buffer_hydra,
            'Activate buffer mode'
        },
    }),
    {
        ['<Leader>1'] = { cmd 'BufferLineGoToBuffer 1', 'Choose buffer #1' },
        ['<Leader>2'] = { cmd 'BufferLineGoToBuffer 2', 'Choose buffer #2' },
        ['<Leader>3'] = { cmd 'BufferLineGoToBuffer 3', 'Choose buffer #3' },
        ['<Leader>4'] = { cmd 'BufferLineGoToBuffer 4', 'Choose buffer #4' },
        ['<Leader>5'] = { cmd 'BufferLineGoToBuffer 5', 'Choose buffer #5' },
        ['<Leader>6'] = { cmd 'BufferLineGoToBuffer 6', 'Choose buffer #6' },
        ['<Leader>7'] = { cmd 'BufferLineGoToBuffer 7', 'Choose buffer #7' },
        ['<Leader>8'] = { cmd 'BufferLineGoToBuffer 8', 'Choose buffer #8' },
        ['<Leader>9'] = { cmd 'BufferLineGoToBuffer 9', 'Choose buffer #9' },
        ['<Leader>$'] = { cmd 'BufferLineGoToBuffer -1', 'Choose last buffer' },
  }
}
