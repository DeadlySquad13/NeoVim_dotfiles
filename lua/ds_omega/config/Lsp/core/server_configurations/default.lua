local lsp_handlers = require('ds_omega.config.Lsp.core.handlers')

local default_server_config = {
  on_attach = lsp_handlers.on_attach,
  capabilities = lsp_handlers.capabilities,
  settings = {},
}

return default_server_config
