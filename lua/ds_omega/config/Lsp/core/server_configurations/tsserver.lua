local lsp_handlers = require('ds_omega.config.Lsp.core.handlers')
local prequire = require('ds_omega.utils').prequire

local function setup_ts_utils(client)
  local ts_utils_is_available, ts_utils = prequire('nvim-lsp-ts-utils')

  if not ts_utils_is_available then
    return
  end

  ts_utils.setup({
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,

    -- Import all.
    import_all_timeout = 5000, -- ms
    -- Lower numbers = higher priority.
    import_all_priorities = {
      same_file = 1, -- add to existing import statement
      local_files = 2, -- git files or files with relative path markers
      buffer_content = 3, -- loaded buffer content
      buffers = 4, -- loaded buffer names
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,
    -- If false will avoid organizing imports.
    always_organize_imports = true,

    -- Filter diagnostics.
    filter_out_diagnostics_by_severity = {},
    filter_out_diagnostics_by_code = {},

    -- Inlay hints.
    auto_inlay_hints = true,
    inlay_hints_highlight = 'Comment',
    inlay_hints_priority = 200, -- priority of the hint extmarks
    inlay_hints_throttle = 150, -- throttle the inlay hint request
    inlay_hints_format = { -- format options for individual hint kind
      Type = {},
      Parameter = {},
      Enum = {},
      -- Example format customization for `Type` kind:
      -- Type = {
      --     highlight = "Comment",
      --     text = function(text)
      --         return "->" .. text:sub(2)
      --     end,
      -- },
    },

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
  })

  -- required to fix code action ranges and filter diagnostics
  ts_utils.setup_client(client)
end

local function setup_ts_utils_keymappings(_, bufnr)
  -- no default maps, so you may want to define some here
  local opts = { silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)
end

return {
  settings = {
    log = false,
    trace = {
      server = false,
    },
  },

  on_attach = {
    lsp_handlers.disable_formatting,
    lsp_handlers.auto_format_on_save, 
    setup_ts_utils,
    setup_ts_utils_keymappings,
  },
}
