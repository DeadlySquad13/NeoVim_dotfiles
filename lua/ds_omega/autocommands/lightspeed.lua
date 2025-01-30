local is_loaded = require('ds_omega.utils').is_loaded
local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

if not is_loaded('quick-scope') then
  return
end

-- NOTE: clear option - clears previously created autocommands in augroup.

-- ? Move this file to layers?
local Lightspeed = create_augroup('lightspeed-quickscope', { clear = true })

local function disable_quick_scope()
  if vim.g.qs_enable == 1 then
    return vim.cmd('QuickScopeToggle')
  end
end

create_autocmd({ 'User' }, {
  group = Lightspeed,
  pattern = 'LightspeedSxEnter',
  desc = 'Disable quickscope during lightspeed jumps',
  callback = disable_quick_scope
})


local function enable_quick_scope()
  if vim.g.qs_enable == 0 then
    return vim.cmd('QuickScopeToggle')
  end
end

create_autocmd({ 'User' }, {
  group = Lightspeed,
  pattern = 'LightspeedSxLeave',
  desc = 'Enable quickscope back after lightspeed jumps',
  callback = enable_quick_scope
})
