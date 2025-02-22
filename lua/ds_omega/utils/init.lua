------------------------------------------------------------------
-- General purpose utils (mostly used for writing pretty code). --
------------------------------------------------------------------

-- Shortcut for printing variables in a meaningless way: showing contents of a
--   table via vim.inspect. Used log as console.log in js works pretty the same
--   way.
local function log(data)
  vim.print(data)
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

---@type 'packer' | 'lazy'
local CURRENT_PLUGIN_MANAGER = 'lazy'

local function exists_in_packer_spec(plugin_name)
  return packer_plugins and packer_plugins[plugin_name]
end

local function is_loaded_in_packer_spec(plugin_name)
  return exists(plugin_name) and packer_plugins[plugin_name].loaded
end

-- Not sure if it's lazy specific way.
local function is_loaded_in_lazy_spec(plugin_name)
  local plugin = package.loaded[plugin_name]

  return plugin and not vim.tbl_isempty(plugin)
end

local function exists(plugin_name)
    if CURRENT_PLUGIN_MANAGER == 'packer' then
        return exists_in_packer_spec(plugin_name)
    elseif CURRENT_PLUGIN_MANAGER == 'lazy' then
        print("Function 'exists' is not implemented for lazy")
        return nil
    end
end

local function is_loaded(plugin_name)
    if CURRENT_PLUGIN_MANAGER == 'packer' then
        return is_loaded_in_packer_spec(plugin_name)
    elseif CURRENT_PLUGIN_MANAGER == 'lazy' then
        return is_loaded_in_lazy_spec(plugin_name)
    end
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
  -- Just reuses global prequire, left here for clarity in old modules.
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
  file = require('ds_omega.utils.file'),

  -- # Collections.
  IndexedSet = IndexedSet,

  -- * Collection utils. @see also `:h vim.tbl_*`.
  tbl_remove_key = tbl_remove_key,
  list_deep_extend = list_deep_extend,

  os = require('ds_omega.utils.os'),

  exec = require('ds_omega.utils.exec'),

  Set = require('ds_omega.utils.set').Set,

  SetIntersection = require('ds_omega.utils.set').SetIntersection,
}

return M
