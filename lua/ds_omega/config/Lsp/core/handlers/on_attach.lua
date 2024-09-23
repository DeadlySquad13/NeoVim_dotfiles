local prequire = require('ds_omega.utils').prequire

local setup_lsp_keymappings = require('ds_omega.config.Lsp.core.handlers.setup_lsp_keymappings')
local setup_symbol_highlight_under_cursor = require('ds_omega.config.Lsp.core.handlers.setup_symbol_highlight_under_cursor')
local setup_filter_diagnostics_by_severity = require('ds_omega.config.Lsp.core.handlers.filter_diagnostics_by_severity')

local on_attach = function(client, bufnr)
  local filter_diagnostics_by_severity_keymappings = setup_filter_diagnostics_by_severity()
  setup_lsp_keymappings(bufnr, { filter_diagnostics_by_severity_keymappings })

  if not require('ds_omega.utils').is_loaded('vim-illuminate') then
    setup_symbol_highlight_under_cursor(client)
  end

    local lsp_signature_is_available, lsp_signature = prequire('lsp_signature')

    if lsp_signature_is_available then
      lsp_signature.on_attach({
          bind = true, -- This is mandatory, otherwise border config won't get registered.
          handler_opts = {
            border = "none"
         }
        }, bufnr)
    end

  --Enable completion triggered by <c-x><c-o>
  --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  --if vim.g.logging_level == 'debug' then
  --local msg = string.format("Language server %s started!", client.name)
  --vim.notify(msg, 'info', {title = 'Nvim-config'})
  --end
end


return on_attach
