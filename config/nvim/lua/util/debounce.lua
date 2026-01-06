local function debounce(ms, fn)
  local timer = vim.uv.new_timer()

  return function(...)
    if timer ~= nil then
      local argv = { ... }
      timer:start(ms, 0, function()
        timer:stop()
        vim.schedule_wrap(fn)(unpack(argv))
      end)
    end
  end
end

return debounce
