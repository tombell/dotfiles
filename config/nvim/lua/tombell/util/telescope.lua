local util = require "tombell.util"

local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }

  return function()
    builtin = params.builtin
    opts = vim.tbl_deep_extend("force", { cwd = util.root() }, opts or {})

    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") and opts.git then
        opts.show_untracked = true
        builtin = "git_files"
      else
        opts.find_command = { "rg", "--files", "--color", "never", "--glob", "!.git/*" }
        opts.hidden = true
        builtin = "find_files"
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

function M.config_files()
  return M.telescope("find_files", { cwd = vim.fn.stdpath "config" })
end

return M
