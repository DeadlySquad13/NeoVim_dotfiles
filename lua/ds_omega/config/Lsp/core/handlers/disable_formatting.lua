local prequire = require('ds_omega.utils').prequire

--- Disables formatting provided by lsp server if the null-ls is available.
---@param client
local function disable_formatting(client)
  local formatting_is_available = prequire('null-ls')

  -- TOFIX: additional check for formatting_is_available_for_specific_language.
  -- TODO: make this check as separate function checker like with packer plugins.
  if formatting_is_available then
    client.server_capabilities.document_formatting = false
  end
end

return disable_formatting
