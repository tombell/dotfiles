local Snacks = require "snacks"
local util = require "util"

--- Helper to create Snacks.picker functions with common options
---@param fn string The picker function name
---@param opts table? Additional options to merge
---@return function
local function picker(fn, opts)
  return function()
    Snacks.picker[fn](vim.tbl_extend("force", { cwd = util.root() }, opts or {}))
  end
end

return picker
