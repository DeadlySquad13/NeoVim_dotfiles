return {
    "cshuaimin/ssr.nvim",
    -- Calling setup is optional.
    keys = {
        {
            mode = { "n", "x" },
            "<Leader>sr",
            function() require("ssr").open() end,
            desc = "Structural search & replace",
        },
    },
    opts = {
        border = "rounded",
        min_width = 50,
        min_height = 5,
        max_width = 120,
        max_height = 25,
        adjust_window = true,
        keymaps = {
            close = "<Esc>",
            next_match = "<Tab>",
            prev_match = "<S-Tab>",
            replace_confirm = "<Cr>",
            replace_all = "<Leader><Cr>",
        },
    }
}
