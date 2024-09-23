local prequire = require('ds_omega.utils').prequire

--- Enable auto format on save if the lsp-format is available.
---@param client
local function auto_format_on_save(client)
  local lsp_format_is_available, lsp_format = prequire('lsp-format')

  if not lsp_format_is_available then
    return
  end

  lsp_format.on_attach(client)
end

return auto_format_on_save
