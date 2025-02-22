-- PATH environment variables defined specifically for vim.
--   Directory variables should end without trailing slash.
local home = vim.fn.getenv('HOME')
local user_config = home .. '/.config'
local bookmarks = home .. '/.bookmarks'

local kbn = bookmarks .. '/kbd'
-- local references = kbn .. '/InfoField__References'
-- local references = kbn
local references = home .. '/InfoField__References'

local projects = bookmarks .. '/projects'
local ephemeral_projects = projects .. '/ephemeral-'
local interim_projects = projects .. '/interim-'

local namespace_name = 'ds_omega'

-- Resolves to `~/.local/share/nvim`.
local nvim_data = vim.fn.stdpath('data')


-- Takes $NVIM_APPNAME into consideration.
local nvim_config = vim.fn.stdpath('config')
local gui_settings = nvim_config .. '/ginit.vim'
local nvim_lua = nvim_config .. '/lua'
local nvim_lua_namespace = nvim_lua .. '/' .. namespace_name
local nvim_general_settings = nvim_lua .. '/general_settings.lua'
local nvim_plugins = nvim_lua .. '/plugins.lua'
local nvim_layers_specification = nvim_lua .. '/layers_specification.lua'

local nvim_after = nvim_config .. '/after'
local nvim_queries = nvim_after .. '/queries'

local nvim_autocommands = nvim_lua_namespace .. '/autocommands'
local nvim_constants = nvim_lua_namespace .. '/constants' -- TODO: Separate and move to config / layer system?
local nvim_lua_config = nvim_lua_namespace .. '/config'
local nvim_keymappings = nvim_lua_namespace .. '/keymappings'
local nvim_commands = nvim_lua_namespace .. '/commands'
local nvim_modules = nvim_lua_namespace .. '/modules'
local nvim_layers = nvim_lua_namespace .. '/layers'

local goneovim_settings = user_config .. '/goneovim/settings.toml'

---@type table<'file'|'messages'|'notify', boolean>
LOG_INTO = require('ds_omega.utils.set').Set({
  -- 'file',
  'messages',
  -- 'notify'
})

return {
  HOME = home,
  USER_CONFIG = user_config,
  BOOKMARKS = bookmarks,

  KBN = kbn,
  REFERENCES = references,

  PROJECTS = projects,
  EPHEMERAL_PROJECTS = ephemeral_projects,
  INTERIM_PROJECTS = interim_projects,

  NAMESPACE_NAME = namespace_name,

  -- Directory where all supplementary data files are stored, such as: undo
  -- history, spell files, sessions...
  NVIM_DATA = nvim_data,
  GUI_SETTINGS = gui_settings,

  NVIM_CONFIG = nvim_config,
  NVIM_GENERAL_SETTINGS = nvim_general_settings,
  NVIM_LUA = nvim_lua,
  NVIM_LUA_NAMESPACE = nvim_lua_namespace,
  NVIM_PLUGINS = nvim_plugins,
  NVIM_LAYERS_SPECIFICATION = nvim_layers_specification,
  NVIM_AUTOCOMMANDS = nvim_autocommands,
  NVIM_CONSTANTS = nvim_constants,
  NVIM_LUA_CONFIG = nvim_lua_config,
  NVIM_KEYMAPPINGS = nvim_keymappings,
  NVIM_COMMANDS = nvim_commands,
  -- Candidates to become plugins.
  NVIM_MODULES = nvim_modules,

  NVIM_LAYERS = nvim_layers,
  NVIM_AFTER = nvim_after,
  NVIM_QUERIES = nvim_queries,

  GONEOVIM_SETTINGS = goneovim_settings,
}
