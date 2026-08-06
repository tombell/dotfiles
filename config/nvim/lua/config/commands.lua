vim.api.nvim_create_user_command("W", "write", {})

for _, command in ipairs { "Wqa", "WQa", "WQA" } do
  vim.api.nvim_create_user_command(command, "wqall", {})
end
