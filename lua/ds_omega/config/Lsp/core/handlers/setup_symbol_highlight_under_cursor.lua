local function setup_symbol_highlight_under_cursor(client)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  -- The command below will highlight the current variable and its usages in the buffer.
  -- TODO: rewrite to nvim_create_autocmd and nvim_set_hi.
  vim.cmd([[
    hi! link LspReferenceRead Visual
    hi! link LspReferenceText Visual
    hi! link LspReferenceWrite Visual
    augroup LspDocumentHighlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
  ]])
end

return setup_symbol_highlight_under_cursor
