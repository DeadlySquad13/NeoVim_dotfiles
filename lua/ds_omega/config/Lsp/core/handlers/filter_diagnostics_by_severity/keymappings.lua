local DESCRIPTION_BASE = 'Set min diagnostics severity level to '

return {
  n = {
    ['<leader>d'] = {
      n = { '<Cmd>SetMinDiagnosticsSeverity NONE<Cr>', 'Hide all diagnostics'},
      e = { '<Cmd>SetMinDiagnosticsSeverity ERROR<Cr>', DESCRIPTION_BASE .. 'ERROR' },
      w = { '<Cmd>SetMinDiagnosticsSeverity WARN<Cr>', DESCRIPTION_BASE .. 'WARN' },
      i = { '<Cmd>SetMinDiagnosticsSeverity INFO<Cr>', DESCRIPTION_BASE .. 'INFO' },
      h = { '<Cmd>SetMinDiagnosticsSeverity HINT<Cr>', DESCRIPTION_BASE .. 'HINT' },
      a = { '<Cmd>SetMinDiagnosticsSeverity ALL<Cr>', 'Show all diagnostics' },
    },
  }
}
