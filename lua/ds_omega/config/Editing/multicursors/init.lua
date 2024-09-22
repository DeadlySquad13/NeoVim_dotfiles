return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'nvimtools/hydra.nvim',
    },
    -- version = "v1.0.0",
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
            {
                mode = { 'v', 'n' },
                'xa',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
            {
                mode = { 'v', 'n' },
                'xc',
                '<cmd>MCunderCursor<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
        },
}
