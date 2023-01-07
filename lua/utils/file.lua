---------------------------------------------------------------------------------
------------------------------ File System utils. -------------------------------
---------------------------------------------------------------------------------

---  Most of the basic file system related functionality is implemented in neovim.
-- This module aims to integrate different plugins (mostly telescope) with
-- neovim's api.

local file = {}

file.edit_file = function(path)
  return vim.cmd('e ' .. path)
end

---  Converts path to runtimepath (see `:h runtimepath`) or more specifically to
-- stdpath('config') (see `:h stdpath`).
---@param path (string) Path that looks like
-- `home/dubuntus/.config/nvim/lua/config/incline.lua`
---@return (string) path Path thats truncated at the beggining (as if starting relatively
-- from stdpath('config')):
-- `lua/config/incline.lua`.
file.convert_to_runtimepath = function(path)
  local path_with_truncated_runtimepath = string.gsub(
    path,
    vim.fn.stdpath('config'),
    ''
  )

  -- Removing first slash.
  return path_with_truncated_runtimepath:sub(2)
end

-- TODO: Make default_text as regex.

--- Open lua module: if only one file exists, jump to it immediately, otherwise
-- open directory in file_browser.
---@param path (string) Absolute path.
---@param opts (table | nil) Telescope picker options.
---@return unknown
file.open_lua_module = function(path, opts)
  local path_relative_to_runtimepath = file.convert_to_runtimepath(path)
  local files = vim.api.nvim_get_runtime_file(
    path_relative_to_runtimepath .. '/*.lua',
    true
  )

  -- Can just jump to file, it's anyway the only one existing.
  if #files == 1 then
    return file.edit_file(files[1])
  end

  local picker = require('telescope').extensions.file_browser.file_browser

  return picker(vim.tbl_extend('force', { cwd = path }, opts or {}))
end

---  Depending on target uses appropriate callback.
-- If it's file - opens it, if it's directory - opens file_browser.
---@param path (string) Absolute path.
---@param opts (table | nil) Telescope picker options.
---@return unknown
file.open = function(path, opts)
  if vim.fn.isdirectory(path) == 0 then
    return file.edit_file(path)
  end

  return file.open_lua_module(path, opts)
end

return file
