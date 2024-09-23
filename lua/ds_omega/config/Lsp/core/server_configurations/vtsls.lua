local lsp_handlers = require('ds_omega.config.Lsp.core.handlers')

local function setup_vtscs_keymappings(_, bufnr)
  local opts = { silent = true }
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rf', ':Vts Rename ', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)
end

return {
  on_attach = {
    -- lsp_handlers.disable_formatting,
    lsp_handlers.auto_format_on_save,
    setup_vtscs_keymappings,
  },
}
