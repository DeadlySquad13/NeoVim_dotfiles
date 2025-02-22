local is_loaded = require('ds_omega.utils').is_loaded
local create_user_command = require('ds_omega.utils.commands').create_user_command
local ENV = require('ds_omega.constants.env')

local luasnip_loaders_is_available, luasnip_loaders = pcall(
  require,
  'luasnip.loaders'
)

-- LuaSnip engine commands for editing snippets.
if luasnip_loaders_is_available then
  create_user_command('ChooseLuaSnipEdit', luasnip_loaders.edit_snippet_files, {
    nargs = 0,
  })
  -- TODO: check how to pick automatically appropriate file.
  create_user_command('LuaSnipEdit', luasnip_loaders.edit_snippet_files, {
    nargs = 0,
  })

  create_user_command('LuaSnipSource', function()
    local luasnip_config_path = ENV.NVIM_LUA_CONFIG .. '/luasnip.lua'
    local sourced_successfully = pcall(
      vim.cmd,
      'source ' .. luasnip_config_path
    )

    if not sourced_successfully then
      return notify(
        'Could not load config `' .. luasnip_config_path .. '`!',
        vim.log.levels.ERROR,
        {
          title = 'LuaSnip',
        }
      )
    end

    return notify('Sourced config', vim.log.levels.SUCCESS, {
      title = 'LuaSnip',
    })
  end, {
    nargs = 0,
    desc = 'Source LuaSnip file to reload snippets and settings',
  })
end

-- Deciding which snippet engine command to use for editing snippets.
if luasnip_loaders_is_available then
  create_user_command('ChooseSnippetsEdit', 'LuaSnipEdit', {
    nargs = 0,
  })
elseif is_loaded('ultisnips') then
  create_user_command('ChooseSnippetsEdit', 'UltiSnipsEdit!', {
    nargs = 0,
  })
  create_user_command('SnippetsEdit', 'UltiSnipsEdit', {
    nargs = 0,
  })
end
