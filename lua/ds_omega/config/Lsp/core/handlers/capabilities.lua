local prequire = require('ds_omega.utils').prequire

local capabilities_are_available, capabilities = prequire('cmp_nvim_lsp')

if capabilities_are_available then
  capabilities = capabilities.default_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true
else
  capabilities = {
    textDocument = {}
  }
end

---  nvim-ufo: Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually.
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

return capabilities
