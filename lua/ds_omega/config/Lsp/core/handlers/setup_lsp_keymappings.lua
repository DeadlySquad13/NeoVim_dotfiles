local which_key_utils = require('ds_omega.config.Ui.which_key.utils')
local keymappings_utils = require('ds_omega.config.keymappings._common.utils')
local cmd, merge = keymappings_utils.cmd, keymappings_utils.merge

--- Apply all lsp related keymappings.
---@param bufnr (integer)
---@param additional_keymappings (table | nil) # Keymappings provided by
--additional lsp handlers.
local setup_lsp_keymappings = function(bufnr, additional_keymappings)
    additional_keymappings = additional_keymappings or {}
    local lsp_buf = vim.lsp.buf
    local prequire = require('ds_omega.utils').prequire

    local lsp_diagnostic = vim.diagnostic

    local lspsaga_diagnostic_is_available, lspsaga_diagnostic =
        prequire('lspsaga.diagnostic')

    if lspsaga_diagnostic_is_available then
        lsp_diagnostic = lspsaga_diagnostic
    end

    local keymappings = {}

    -- * General.
    --nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

    -- * Investigation.
    -- - Implementation.
    --nnoremap <silent> <leader>gii <cmd>lua vim.lsp.buf.implementation()<CR>

    -- - Declaration.
    --nnoremap <silent> <leader>giD <cmd>lua vim.lsp.buf.declaration()<CR>

    -- - Type definition.
    --nnoremap <silent> <leader>git <cmd>lua vim.lsp.buf.type_definition()<CR>

    -- * Searching.
    --nnoremap <silent> <leader>g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
    --nnoremap <silent> <leader>gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

    local function filterReactDTS(value)
        return string.match(value.filename, 'react/index.d.ts') == nil
    end

    local function on_list(options)
        -- [https://github.com/typescript-language-server/typescript-language-server/issues/216](https://github.com/typescript-language-server/typescript-language-server/issues/216)
        local items = options.items
        if #items > 1 then
            items = vim.tbl_filter(filterReactDTS, items)
        end

        vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
        vim.api.nvim_command('cfirst')
    end

    local glance_is_available = prequire('glance')
    local actions_preview_is_available, actions_preview = prequire('actions-preview')
    local code_action = actions_preview_is_available and actions_preview.code_actions or lsp_buf.code_action

    keymappings.n = {
        name = 'LSP',

        -- General.
        ['<Leader>wa'] = { lsp_buf.add_workspace_folder, 'Add workspace folder' },
        ['<Leader>wr'] = {
            lsp_buf.remove_workspace_folder,
            'Remove workspace folder',
        },
        ['<Leader>wl'] = {
            function()
                vim.print(lsp_buf.list_workspace_folders())
            end,
            'List workspace folders',
        },

        -- Investigation.
        ['gd'] = { function()
            lsp_buf.definition({ on_list = on_list })
        end, 'Jump to definition' },
        ['<c-k>'] = { lsp_buf.signature_help, 'Signature help' },
        ['<Leader>i'] = merge(
            {
                i = { lsp_buf.hover, 'Hover' },
                d = {
                    cmd 'Lspsaga show_line_diagnostics',
                    'Investigate line diagnostics',
                },
                r = {
                    function() lsp_buf.references(nil, { on_list = on_list }) end,
                    'List References'
                },
            }, not glance_is_available and {} or {
                D = {
                    cmd 'Glance definitions',
                    'Glance at definitions'
                },
                R = {
                    cmd 'Glance references',
                    'Glance at references'
                },
            }
        ),
        -- Editing.
        ['<Leader>rs'] = { lsp_buf.rename, 'Rename Symbol' },
        ['<Leader>aa'] = { code_action, 'Code Action' },
        ['<Leader>qd'] = {
            function()
                vim.diagnostic.setqflist({ open = true })
            end,
            'Send diagnostic to quickfix list',
        },
        ['<Leader>ff'] = { lsp_buf.format, 'Format' },

        -- Navigation.
        ['[d'] = {
            function()
                lsp_diagnostic:goto_prev()
            end, 'Go to previous diagnostic'
        },
        [']d'] = {
            function()
                lsp_diagnostic:goto_next()
            end,
            'Go to next diagnostic'
        },

        ['[e'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.ERROR, popup_opts = { border = "single" } })
            end,
            'Go to previous error',
        },
        [']e'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.ERROR, popup_opts = { border = "single" } })
            end,
            'Go to next error',
        },

        ['[w'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.WARN })
            end,
            'Go to previous warning',
        },
        [']w'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.WARN })
            end,
            'Go to next warning',
        },

        ['[i'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.INFO })
            end,
            'Go to previous info diagnostic',
        },
        [']i'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.INFO })
            end,
            'Go to next info diagnostic',
        },

        ['[h'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.HINT })
            end,
            'Go to previous hint',
        },
        [']h'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.HINT })
            end,
            'Go to next hint',
        },
    }

    keymappings.x = {
        ['<Leader>ff'] = { lsp_buf.format, 'Format' },
    }

    local options = {
        buffer = bufnr,
    }

    local merged_keymappings = keymappings
    -- TODO: get all modes from `apply_keymappings`.
    for _, mode in ipairs(which_key_utils.MODES) do
        local additional_keymappings_for_mode = vim.tbl_map(
            function(k) return k[mode] end,
            additional_keymappings
        )

        if not vim.tbl_isempty(additional_keymappings_for_mode) then
            merged_keymappings[mode] = vim.tbl_extend('error',
                keymappings[mode] or {},
                unpack(additional_keymappings_for_mode)
            )
        end

        if merged_keymappings[mode] then
            which_key_utils.apply_keymappings(mode, merged_keymappings[mode], options)
        end
    end
end

return setup_lsp_keymappings
