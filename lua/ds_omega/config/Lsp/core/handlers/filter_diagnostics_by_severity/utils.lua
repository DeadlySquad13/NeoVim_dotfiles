local function filter_diagnostics_by_severity(diagnostics, severity)
  local filtered_diagnostics = {}

  for _, diagnostic in ipairs(diagnostics) do
    -- The most severe is 1, the least - 4, so even though we are filtering for
    -- minimum severity, the comparison is negated.
    if diagnostic.severity <= severity then
      -- preprend?
      table.insert(filtered_diagnostics, 1, diagnostic)
    end
  end

  return filtered_diagnostics
end

local original_handler = vim.diagnostic.handlers.virtual_text
local ns = vim.api.nvim_create_namespace("my_diagnostics")

--- 
---@param severity (1 | 2 | 3 | 4) # One of vim.diagnostic.severity.
---@example
----- Show only errors.
--set_diagnostics_severity(vim.diagnostic.severity.ERROR)
----- Show only errors and warnings.
--set_diagnostics_severity(vim.diagnostic.severity.WARN)
local function set_minimum_diagnostics_severity(severity)
  --[[
  vim.diagnostic.*() invokes all handlers, virtual_text is one of them.

  1. Use original handlers' to hide **all** diagnostics.
  2. Override handlers' show and hide to show_new and hide_new.
  3. Use show handlers with now overriden show_new.

    Next time we use this function, handlers have hide_new
  so step 1 will invoke hide only diagnostics from our namespace.
  --]]

  local bufnr = vim.api.nvim_get_current_buf()

  -- Hide original lsp diagnostics.
  vim.diagnostic.hide(nil, bufnr)

  vim.diagnostic.handlers.virtual_text = {
    show = function(_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      local filtered_diagnostics = filter_diagnostics_by_severity(diagnostics, severity)

      original_handler.show(ns, bufnr, filtered_diagnostics, opts)
    end,

    hide = function(_, bufnr)
      original_handler.hide(ns, bufnr)
    end
  }

  local diagnostics = vim.diagnostic.get(bufnr)

  if #diagnostics == 0 then
    return
  end

  local filtered_diagnostics = filter_diagnostics_by_severity(diagnostics, severity)
  vim.diagnostic.show(ns, bufnr, filtered_diagnostics)
end

return {
  set_minimum_diagnostics_severity = set_minimum_diagnostics_severity,
}

