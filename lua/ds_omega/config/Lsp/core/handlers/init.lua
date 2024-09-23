return {
  capabilities = require('ds_omega.config.Lsp.core.handlers.capabilities'),
  on_attach = require('ds_omega.config.Lsp.core.handlers.on_attach'),
  disable_formatting = require('ds_omega.config.Lsp.core.handlers.disable_formatting'),
  auto_format_on_save = require('ds_omega.config.Lsp.core.handlers.auto_format_on_save'),
}
