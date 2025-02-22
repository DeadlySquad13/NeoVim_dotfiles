local AUTOCOMMANDS = {
  'luasnip',
  'filetype_sets',
  'highlight_on_yank',
  'revisit_last_position_in_file',
  'set_format_options',
}

for _, module in ipairs(AUTOCOMMANDS) do
  prequire('ds_omega.autocommands.' .. module)
end
