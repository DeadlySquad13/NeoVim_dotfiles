------------------------------------------------------------------
-- General purpose utils (mostly used for writing pretty code). --
------------------------------------------------------------------
local env = require('constants.env')

--  Prints prettily the data and returns it without any changes. Used for
--testing.
---@param data any data.
---@return data without changes.
_G.P = function(data)
  vim.pretty_print(data)
  return data
end

--- Notify user with nvim.notify. If it is not available, fallback to
--vim.notify.
---@param message (string) Message to display.
---@param level #Level of notification (see `:h vim.log.levels`).
---@param opts (table|nil) Additional options for nvim.notify visualization (see `:h
--notify.Options`).
_G.notify = function(message, level, opts)
  local nvim_notify_is_available, nvim_notify = pcall(require, 'notify')

  local notify = vim.notify
  if nvim_notify_is_available then
    notify = nvim_notify
  end

  notify(message, level, opts)
end

--- Protected require of the module.
---@param module_name (string)
---@return (boolean), module|nil)
local function prequire(module_name)
  local module_loading_error_handler = function(error)
    notify(
      'Error in loading module ' .. module_name .. '!',
      vim.log.levels.ERROR
    )
  end

  local status_ok, module = xpcall(
    require,
    module_loading_error_handler,
    module_name
  )

  if not status_ok then
    return status_ok, nil
  end

  return status_ok, module
end
_G.prequire = prequire

local outfile = string.format("%s/debug.log", vim.api.nvim_call_function("stdpath", {"data"}))

-- See [debuglog source](https://github.com/smartpde/debuglog/blob/main/lua/debuglog.lua).
_G.log = function(name, hl, opts)
  local debuglog_is_available, debuglog = prequire('debuglog')

  --   dlog is just a shim to a debuglog plugin. It won't work until plugin is
  -- loaded therefore I can't use logging before plugins loading.
  if debuglog_is_available then
    -- FIX: Somehow it's delayed if invoked in layer configurations.
    debuglog.enable(name)
    return require('utils.dlog')(name, hl, opts)
  end

  return function(...)
    if LOG_INTO.messages then
      local message = string.format(...)
      vim.api.nvim_echo({
        {os.date("%H:%M:%S:")}, {" "}, {name},
        {": "}, {message}
      }, true, {})
    end
    if LOG_INTO.file then
      local fp = io.open(outfile, "a")
      local str = os.date("%H:%M:%S: ") .. string.format(...) .. "\n"

      if not fp then
        return
      end

      fp:write(str)
      fp:close()
    end
  end
end

-- Shortcut for printing variables in a meaningless way: showing contents of a
--   table via vim.inspect. Used log as console.log in js works pretty the same
--   way.
local function log(data)
  vim.pretty_print(data)
end

--- Creates new function with default parameters.
---@ref https://gist.github.com/stuartpb/975399
---@usage:
--- myfunction = fancyparams(
---   {{"a"},{"b",7},{"c",5}},
---   function(a, b, c)
---     print(a, b, c)
---   end
--- );
--- myfunction({ a = 8 )}; -- b and c have defaults!
---
---@param arg_def table with parameters with their default values.
---@param f function to which are default parameters are applied.
---@return (function) # New function with default parameters.
local function fancyparams(arg_def, f)
  return function(args)
    local params = {}
    for i = 1, #arg_def do
      local paramname = arg_def[i][1] --the name of the first parameter to the function
      local default_value = arg_def[i][2]
      params[i] = args[i] or args[paramname] or default_value
    end
    return f(unpack(params, 1, #arg_def))
  end
end


local function apply_global_variables(global_variables)
  for name, value in pairs(global_variables) do
    vim.g[name] = value
  end
end

local function exists(plugin_name)
  return packer_plugins and packer_plugins[plugin_name]
end

local function is_loaded(plugin_name)
  return exists(plugin_name) and packer_plugins[plugin_name].loaded
end

--- Convert list to the table that you can use for fast find.
-- It is indexed so you can easily get index of the item in initial list. If
-- you work with large list, you may need `Set`.
---@param list (table) list of items { 'a', 'b', 'c' }.
---@return (table) table #table of items { 'a' = 1, 'b' = 2, 'c' = 3 }.
local function IndexedSet(list)
  local set = {}
  for i, item in ipairs(list) do
    set[item] = i
  end
  return set
end

---Create a function that runs functions passed in the argument.
--They will be called in the same order that they were passed in.
--Useful for composing multiple `on_attach` functions.
---@vararg (function) variable number of functions
---@return (function) composed function that will run all functions (accepts
--variable number of arguments).
local function compose(...)
  local fns = { ... }

  return function(...)
    for _, fn in ipairs(fns) do
      fn(...)
    end
  end
end

--- Pop element from table by key.
---@param table (table)
---@param key (string)
---@return (any) element
local function tbl_remove_key(table, key)
  local element = table[key]
  table[key] = nil
  return element
end

--- Extend list.
--Doesn't modify the initial list and accepts variable number of parameters.
---@param initial_list (any[]) List to extend.
---@vararg (any[]) Lists to extend with.
---@return (any[]) extended_list Extended list.
local function list_deep_extend(initial_list, ...)
  local args = { ... }
  local result = vim.deepcopy(initial_list)

  for _, values in ipairs(args) do
    vim.list_extend(result, values)
  end

  return result
end

local M = {
  -- # Core
  prequire = prequire,

  -- # Printing and loggin.
  log = log,

  -- # Vim api.
  create_augroup = vim.api.nvim_create_augroup,
  create_autocmd = vim.api.nvim_create_autocmd,

  apply = {
    variables = {
      global = apply_global_variables,
    },
  },

  exists = exists,
  is_loaded = is_loaded,

  -- # Functional programming.
  compose = compose,
  fp = fancyparams,

  -- # File System.
  file = require('utils.file'),

  -- # Collections.
  IndexedSet = IndexedSet,

  -- * Collection utils. @see also `:h vim.tbl_*`.
  tbl_remove_key = tbl_remove_key,
  list_deep_extend = list_deep_extend,

  os = require('utils.os'),

  exec = require('utils.exec'),
}

  exec = require('utils.exec'),

  Set = require('utils.Set').Set,

  SetIntersection = require('utils.Set').SetIntersection,
}

return M
