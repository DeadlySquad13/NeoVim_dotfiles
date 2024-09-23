local lsp_handlers = require('ds_omega.config.Lsp.core.handlers')

return {
    on_attach = {
        lsp_handlers.auto_format_on_save,
    },
}
