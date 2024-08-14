return {
    "nvim-telescope/telescope-bibtex.nvim",

    dependencies = {
        'nvim-telescope/telescope.nvim',
    },

    opts = function()
        local function process_telescope_picker(prompt_bufnr)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            local action_state = require('telescope.actions.state')
            local entry = action_state.get_selected_entry().id.content
            actions.close(prompt_bufnr)

            return { action_state = action_state, entry = entry }
        end
        local function citation_append(telescope_interaction_results)
            local utils = require('telescope-bibtex.utils')

            local opts = {}
            local citation_format = "[@{{label}}]: <{{url}}> '{{title}}'"
            local citation_format_zotero =
            "[z@{{label}}]: <zotero://select/items/@{{label}}> 'Select in Zotero: {{title}}'"

            local citation = utils.format_citation(telescope_interaction_results.entry, citation_format, opts)
            local citation_zotero = utils.format_citation(telescope_interaction_results.entry, citation_format_zotero,
                opts)
            local mode = vim.api.nvim_get_mode().mode
            if mode == 'i' then
                -- vim.api.nvim_put({ citation, citation_zotero }, '', false, true)
                -- vim.api.nvim_feedkeys('a', 'n', true)
                vim.api.nvim_buf_set_lines(0, -1, -1, false, { citation, citation_zotero })
            else
                vim.api.nvim_buf_set_lines(0, -1, -3, false, { citation, citation_zotero })
                -- vim.api.nvim_paste(citation .. '<Cr>' .. citation_zotero, true, -1)
            end
        end

        local function key_append(telescope_interaction_results)
            local mode = vim.api.nvim_get_mode().mode

            -- REFACTOR: Into separate function.
            local url_entry =
                string.format("@%s", telescope_interaction_results.action_state.get_selected_entry().id.name)
            local zotero_select_entry =
                string.format("z@%s", telescope_interaction_results.action_state.get_selected_entry().id.name)

            -- TODO: Make prettier.
            local entry = string.format("[Source][%s]|[Zotero][%s]", url_entry, zotero_select_entry)

            if mode == 'i' then
                vim.api.nvim_put({ entry }, '', false, true)
                vim.api.nvim_feedkeys('a', 'n', true)
            else
                vim.api.nvim_put({ entry }, '', true, true)
            end

            return { url_entry, zotero_select_entry }
        end

        -- Shamelessly got from https://github.com/jakewvincent/mkdnflow.nvim/blob/faf013f7ee254f52b88f57b088f650150409cb24/lua/mkdnflow/links.lua#L92
        -- TODO: Add backwards search from end of the file up to the stopping
        -- point ("## References")
        local get_ref = function(refnr, start_row)
            start_row = start_row or vim.api.nvim_win_get_cursor(0)[1]
            local row = start_row + 1
            local line_count, continue = vim.api.nvim_buf_line_count(0), true
            -- Look for reference
            while continue and row <= line_count do
                local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
                local start, finish, match = string.find(line, '^(%[' .. refnr .. '%]: .*)')
                if match then
                    local _, label_finish = string.find(match, '^%[.-%]: ')
                    continue = false
                    return string.sub(match, label_finish + 1), row, label_finish + 1, finish
                else
                    row = row + 1
                end
            end
        end

        return {
            depth = 1,
            custom_formats = {
                {
                    id = "zotero-select", cite_marker = "zotero://select/items/@%s",
                }
            },
            -- format = 'zotero-select',
            global_files = {
                require("ds_omega.constants.env").REFERENCES .. "/Personal.bib"
                -- require('ds_omega.constants.env').REFERENCES .. "/Zotero.bib"
            },
            search_keys = { "shorttitle", "title", "author", "year", "url" },
            citation_max_auth = 2,
            context = false,
            context_fallback = true,
            wrap = false,

            mappings = {
                i = {
                    -- a string with %s to be replaced by the citation key
                    -- ["<C-a>"] = bibtex_actions.key_append([[\citep{%s}]]),
                    -- a string with keys in {{}} to be replaced

                    -- REFACTOR: Try to make it return a new function that is
                    -- invoked each time (had trouble with
                    -- 'telescope-bibtex' not available at the time of
                    -- function creation)
                    -- REFACTOR: Can reuse bibtex_actions.citation_append for
                    -- first citation but
                    -- I anyway had to include mode logic (but maybe it's not
                    -- needed - nvim_paste can be used for any mode
                    -- according to docs)
                    ["<C-c>"] = function(prompt_bufnr)
                        local telescope_interaction_results = process_telescope_picker(prompt_bufnr)
                        citation_append(telescope_interaction_results)
                    end,

                    ["<Cr>"] = function(prompt_bufnr)
                        local telescope_interaction_results = process_telescope_picker(prompt_bufnr)
                        -- see createLink: https://github.com/jakewvincent/mkdnflow.nvim/blob/main/lua/mkdnflow/links.lua
                        local reference_entry = key_append(telescope_interaction_results)[1]


                        P(reference_entry)
                        local existing_ref = get_ref(reference_entry)
                        P(existing_ref)

                        if not existing_ref then
                            citation_append(telescope_interaction_results)
                        end
                    end,
                }
            }
        }
    end,

    config = function()
        local prequire = require("ds_omega.utils").prequire

        local telescope_is_available, telescope = prequire("telescope")

        if not telescope_is_available then
            return
        end

        telescope.load_extension("bibtex")
    end,
}
