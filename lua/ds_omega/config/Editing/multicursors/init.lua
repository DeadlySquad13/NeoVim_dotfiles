return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        -- "nvimtools/hydra.nvim",
        -- Fork with fix: https://github.com/nvimtools/hydra.nvim/pull/4
        "cathyprime/hydra.nvim",
    },
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
