return {
    "jghauser/papis.nvim",

    enabled = false,

    dependencies = {
        "kkharji/sqlite.lua",
        "MunifTanjim/nui.nvim",
        "pysan3/pathlib.nvim",
        "nvim-neotest/nvim-nio",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
    },
    opts = {

        -- -- List of enabled papis.nvim modules.
        -- enable_modules = {
        --     ["search"] = true, -- Enables/disables the search module
        --     ["completion"] = true, -- Enables/disables the completion module
        --     ["at-cursor"] = true, -- Enables/disables the at-cursor module
        --     ["formatter"] = true, -- Enables/disables the formatter module
        --     ["colors"] = true, -- Enables/disables default highlight groups (you
        --     -- probably want this)
        --     ["base"] = true, -- Enables/disables the base module (you definitely
        --     -- want this)
        --     ["debug"] = false, -- Enables/disables the debug module (useful to
        --     -- troubleshoot and diagnose issues)
        -- },

        -- -- Defines citation formats for various filetypes. When the value is a table, then
        -- -- the first entry is used to insert citations, whereas the second will be used to
        -- -- find references (e.g. by the `at-cursor` module). `%s` stands for the reference.
        -- -- Note that the first entry is a string (where e.g. `\` needs to be excaped as `\\`)
        -- -- and the second a lua pattern (where magic characters need to be escaped with
        -- -- `%`; https://www.lua.org/pil/20.2.html).
        -- cite_formats = {
        --     tex = { "\\cite{%s}", "\\cite[tp]?%*?{%s}" },
        --     markdown = "@%s",
        --     rmd = "@%s",
        --     plain = "%s",
        --     org = { "[cite:@%s]", "%[cite:@%s]" },
        --     norg = "{= %s}",
        -- },

        -- -- What citation format to use when none is defined for the current filetype.
        -- cite_formats_fallback = "plain",

        -- Enable default keymaps.
        enable_keymaps = false,

        -- -- Whether to enable the file system event watcher. When disabled, the database
        -- -- is only updated on startup.
        -- enable_fs_watcher = true,

        -- -- The sqlite schema of the main `data` table. Only the "text" and "luatable"
        -- -- types are allowed.
        -- data_tbl_schema = {
        --     id = { "integer", pk = true },
        --     papis_id = { "text", required = true, unique = true },
        --     ref = { "text", required = true, unique = true },
        --     author = "text",
        --     editor = "text",
        --     year = "text",
        --     title = "text",
        --     shorttitle = "text",
        --     type = "text",
        --     abstract = "text",
        --     time_added = "text",
        --     notes = "luatable",
        --     journal = "text",
        --     volume = "text",
        --     number = "text",
        --     author_list = "luatable",
        --     tags = "luatable",
        --     files = "luatable",
        -- },

        -- -- Path to the papis.nvim database.
        -- db_path = vim.fn.stdpath("data") .. "/papis_db/papis-nvim.sqlite3",

        -- -- Name of the `yq` executable.
        -- yq_bin = "yq",

        -- -- Function to execute when adding a new note. `ref` is the citation key of the
        -- -- relevant entry and `notes_name` is the name of the notes file.
        -- create_new_note_fn = function(papis_id, notes_name)
        --     vim.fn.system(
        --         string.format(
        --             "papis update --set notes %s papis_id:%s",
        --             vim.fn.shellescape(notes_name),
        --             vim.fn.shellescape(papis_id)
        --         )
        --     )
        -- end,

        -- -- Filetypes that start papis.nvim.
        -- init_filetypes = { "markdown", "norg", "yaml" },

        -- -- Papis options to import into papis.nvim.
        -- papis_conf_keys = { "info-name", "notes-name", "dir", "opentool" },

        -- -- Whether to enable pretty icons (requires something like Nerd Fonts)
        -- enable_icons = true,

        -- -- Configuration of the search module.
        -- ["search"] = {

        --     -- Whether to enable line wrap in the telescope previewer.
        --     wrap = true,

        --     -- Whether to initially sort entries by time-added.
        --     initial_sort_by_time_added = true,

        --     -- What keys to search for matches.
        --     search_keys = { "author", "editor", "year", "title", "tags" },

        --     -- Papis.nvim uses a common configuration format for defining the formatting
        --     -- of strings. Sometimes -- as for instance in the below `preview_format` option --
        --     -- we define a set of lines. At other times -- as for instance in the `results_format`
        --     -- option -- we define a single line. Sets of lines are composed of single lines.
        --     -- A line can be composed of either a single element or multiple elements. The below
        --     -- `preview_format` shows an example where each line is defined by a table with just
        --     -- one element. The `results_format` and `popup_format` are examples where (some) of
        --     -- the lines contain multiple elements (and are represented by a table of tables).
        --     -- Each element contains:
        --     --   1. The key whose value is shown
        --     --   2. How it is formatted (here, each is just given as is)
        --     --   3. The highlight group
        --     --   4. (Optionally), `show_key` causes the key's name to be displayed in addition
        --     --      to the value. When used, there are then another two items defining the
        --     --      formatting of the key and its highlight group. The key is shown *before*
        --     --      the value in the preview (even though it is defined after it in this
        --     --      configuration (e.g. `title = Critique of Pure Reason`)).
        --     -- An element may also just contain `empty_line`. This is used to insert an empty line
        --     -- Strings that define the formatting (such as in 2. and 4. above) can optionally
        --     -- be a table, defining, first, an icon, and second, a non-icon version. The
        --     -- `enable_icons` option determines what is used.
        --     preview_format = {
        --         { "author", "%s", "PapisPreviewAuthor" },
        --         { "year", "%s", "PapisPreviewYear" },
        --         { "title", "%s", "PapisPreviewTitle" },
        --         { "empty_line" },
        --         { "journal", "%s", "PapisPreviewValue", "show_key", { "󱀁  ", "%s: " }, "PapisPreviewKey" },
        --         { "type", "%s", "PapisPreviewValue", "show_key", { "  ", "%s: " }, "PapisPreviewKey" },
        --         { "ref", "%s", "PapisPreviewValue", "show_key", { "  ", "%s: " }, "PapisPreviewKey" },
        --         { "tags", "%s", "PapisPreviewValue", "show_key", { "  ", "%s: " }, "PapisPreviewKey" },
        --         { "abstract", "%s", "PapisPreviewValue", "show_key", { "󰭷  ", "%s: " }, "PapisPreviewKey" },
        --     },

        --     -- The format of each line in the the results window. Here, everything is show on
        --     -- one line (otherwise equivalent to points 1-3 of `preview_format`). The `force_space`
        --     -- value is used to force whitespace for icons (so that if e.g. a file is absent, it will
        --     -- show "  ", ensuring that columns are aligned.)
        --     results_format = {
        --         { "files", { " ", "F " }, "PapisResultsFiles", "force_space" },
        --         { "notes", { "󰆈 ", "N " }, "PapisResultsNotes", "force_space" },
        --         { "author", "%s ", "PapisResultsAuthor" },
        --         { "year", "(%s) ", "PapisResultsYear" },
        --         { "title", "%s", "PapisResultsTitle" },
        --     },
        -- },

        -- -- Configuration of the at-cursor module.
        -- ["at-cursor"] = {

        --     -- The format of the popup shown on `:Papis at-cursor show-popup` (equivalent to points 1-3
        --     -- of `preview_format`). Note that one of the lines is composed of multiple elements. Note
        --     -- also the `{ "vspace", "vspace" },` line which is exclusive to `popup_format` and which tells
        --     -- papis.nvim to fill the space between the previous and next element with whitespace (and
        --     -- in effect make whatever comes after right-aligned). It can only occur once in a line.
        --     popup_format = {
        --         {
        --             { "author", "%s", "PapisPopupAuthor" },
        --             { "vspace", "vspace" },
        --             { "files", { " ", "F " }, "PapisResultsFiles" },
        --             { "notes", { "󰆈 ", "N " }, "PapisResultsNotes" },
        --         },
        --         { "year",  "%s", "PapisPopupYear" },
        --         { "title", "%s", "PapisPopupTitle" },
        --     },
        -- },

        -- -- Configuration of formatter module.
        -- ["formatter"] = {

        --     -- This function runs when first opening a new note. The `entry` arg is a table
        --     -- containing all the information about the entry (see above `data_tbl_schema`).
        --     -- This example is meant to be used with the `markdown` filetype.
        --     format_notes_fn = function(entry)
        --         -- Some string formatting templates (see above `results_format` option for
        --         -- more details)
        --         local title_format = {
        --             { "author", "%s ",   "" },
        --             { "year",   "(%s) ", "" },
        --             { "title",  "%s",    "" },
        --         }
        --         -- Format the strings with information in the entry
        --         local title = require("papis.utils"):format_display_strings(entry, title_format, true)
        --         -- Grab only the strings (and disregard highlight groups)
        --         for k, v in ipairs(title) do
        --             title[k] = v[1]
        --         end
        --         -- Define all the lines to be inserted
        --         local lines = {
        --             "---",
        --             'title: "Notes -- ' .. table.concat(title) .. '"',
        --             "---",
        --             "",
        --         }
        --         -- Insert the lines
        --         vim.api.nvim_buf_set_lines(0, 0, #lines, false, lines)
        --         -- Move cursor to the bottom
        --         vim.cmd("normal G")
        --     end,
        --     -- This function runs when inserting a formatted reference (currently by `f/c-f` in
        --     -- Telescope). It works similarly to the `format_notes_fn` above.
        --     format_references_fn = function(entry)
        --         local reference_format = {
        --             { "author",  "%s ",    "" },
        --             { "year",    "(%s). ", "" },
        --             { "title",   "%s. ",   "" },
        --             { "journal", "%s. ",   "" },
        --             { "volume",  "%s",     "" },
        --             { "number",  "(%s)",   "" },
        --         }
        --         local reference_data = require("papis.utils"):format_display_strings(entry, reference_format)
        --         for k, v in ipairs(reference_data) do
        --             reference_data[k] = v[1]
        --         end
        --         return table.concat(reference_data)
        --     end,
        -- },

        -- -- Configurations relevant for parsing `info.yaml` files.
        -- ["papis-storage"] = {

        --     -- As lua doesn't deal well with '-', we define conversions between the format
        --     -- in the `info.yaml` and the format in papis.nvim's internal database.
        --     key_name_conversions = {
        --         time_added = "time-added",
        --     },

        --     -- The format used for tags. Will be determined automatically if left empty.
        --     -- Can be set to `tbl` (if a lua table), `,` (if comma-separated), `:` (if
        --     -- semi-colon separated), ` ` (if space separated).
        --     tag_format = nil,

        --     -- The keys which `.yaml` files are expected to always define. Files that are
        --     -- missing these keys will cause an error message and will not be added to
        --     -- the database.
        --     required_keys = { "papis_id", "ref" },
        -- },
    },
    config = function(_, opts)
        require("papis").setup(opts)
    end,
}
