return {
  default_args = {
    -- For lsp.
    DiffviewOpen = { "--untracked-files=no", "--imply-local" },
    DiffviewFileHistory = { "--base=LOCAL" },
  }
}
