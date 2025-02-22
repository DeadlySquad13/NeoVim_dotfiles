local create_user_command = require('ds_omega.utils.commands').create_user_command

---@ref https://github.com/mrjones2014/load-all.nvim
local fileExtension = '.lua'

local function is_lua_file(filename)
  return filename:sub(- #fileExtension) == fileExtension
end

local function load_all(path, depth)
  local scan = require('plenary.scandir')
  for _, file in ipairs(scan.scan_dir(path, { depth = depth or 0 })) do
    if is_lua_file(file) then
      dofile(file)
    end
  end
end

create_user_command(
  'Reload',
  function()
    -- Flush all loaded modules.
    -- Reload only modules starting with the first param string.
    ---
    ---@param module_name (string)
    local function reload_modules(module_name)
      require("plenary.reload").reload_module(module_name, true)
    end

    reload_modules("config")
    reload_modules("plugins")
    reload_modules("ds_omega")

    -- Load modules back.
    vim.cmd('source $MYVIMRC')

    load_all(require('ds_omega.constants.env').NVIM_LAYERS, 2)
  end,
  { nargs = 0 }
)

---  Simpler `redir` command. Used for redirecting command output (such as
--`:messages`) to the new buffer.
---@example
--```vim
--:Redir :messages
--:Redir lua=vim.tbl_keys(package.loaded)
--```
create_user_command(
  'Redir',
  function(ctx)
    local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n', { plain = true })
    vim.cmd('new')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
  end,
  { nargs = '+', complete = 'command' }
)
