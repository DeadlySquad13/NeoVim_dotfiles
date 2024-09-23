# Table of Contents

- [Table of Contents](#table-of-contents)
- [Server configuration](#server-configuration)

# Server configuration
Configurations in this module are meant to be **merged** with default server
configuration. Make configurations in corresponding files like you always do
with `lsp`:
```lua
return {
  -- These functions be applied on top of default on_attach one by one.
  --   Should take client and bufnr as params (both optional).
  on_attach = { custom_on_attaches },
  -- Will override default settings.
  settings = { },
  
  -- Not yet implemented:
  capabilities = capabilities -- Haven't found any need to override them.
}
```
