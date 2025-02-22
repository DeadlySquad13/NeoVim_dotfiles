local command_modules = {
  'profile',
  'utility',
  'snippets',
}

for _, module in ipairs(command_modules) do
  prequire('ds_omega.commands.'..module)
end
