---@class Item
---@field path (string) Path (can be at first index).
---@field opts (table | nil) Telescope picker options.

---@alias Items table<string, Item|function>

---@param items (Items)
local choose_and_edit_target = function(items)
  vim.ui.select(vim.tbl_keys(items), {
    prompt = 'Choose target to edit',
    telescope = require('telescope.themes').get_dropdown(),
  }, function(selected)
    if not selected then
      return
    end

    local selected_item = items[selected]

    -- Special callback.
    if type(selected_item) == 'function' then
      return selected_item()
    end

    local path = selected_item[1] or selected_item.path
    local opts = selected_item.opts

    require('ds_omega.utils.file').open(path, opts or {})
  end)
end

return choose_and_edit_target
