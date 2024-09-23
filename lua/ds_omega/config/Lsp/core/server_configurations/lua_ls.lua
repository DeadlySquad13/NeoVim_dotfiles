-- local lsp_handlers = require('ds_omega.config.Lsp.core.handlers')

return {
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        }
      },
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        enable = true,
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        maxPreload = 10000,
        preloadFileSize = 10000,
        checkThirdParty = false,
      },
    },
  },
  on_attach = {
    --   Saving overrides current file as if no edits were made until the server
    -- is loaded. May be related to https://github.com/LuaLS/lua-language-server/issues/1049.
    -- lsp_handlers.auto_format_on_save,
  },
}
