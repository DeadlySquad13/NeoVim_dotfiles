local create_user_command = require('ds_omega.utils.commands').create_user_command

create_user_command(
  'ProfileStart',
  function(params)
    vim.cmd.profile({ args = { 'start', params.args } })
    vim.cmd.profile({ args = { 'func', '*' } })
    vim.cmd.profile({ args = { 'file', '*' } })
  end,
  { nargs = 1 }
)

create_user_command(
  'ProfilePause',
  function(params)
    vim.cmd.profile({ args = { 'pause' } })
    vim.cmd.profile({ args = { 'dump' } })
  end,
  { nargs = 0 }
)
