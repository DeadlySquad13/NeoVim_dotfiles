---   Setup commands related to filtering diagnostics
---@return keymappings (table) Related keymappings compatible with which_key.
local function setup_filter_diagnostics_by_severity()
  require('ds_omega.config.Lsp.core.handlers.filter_diagnostics_by_severity.commands')

  return require('ds_omega.config.Lsp.core.handlers.filter_diagnostics_by_severity.keymappings')
end

return setup_filter_diagnostics_by_severity
