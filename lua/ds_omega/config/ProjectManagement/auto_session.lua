return {
  'rmagatti/auto-session',

  lazy = false,

  opts = {
    log_level = 'info',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.expand(require('ds_omega.constants.env').NVIM_DATA .. '/sessions/'),
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil,
    auto_session_use_git_branch = true,
    bypass_session_save_file_types = nil
  },

  config = true,
}
