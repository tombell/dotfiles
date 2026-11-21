-- cwd_debug: what does Rex say the focused terminal's directory is?
--   rex do cwd_debug --json        (or run "Debug: Focused Terminal Directory" from the palette)

local util = require("custom_ui.util")
local repo = require("custom_ui.repo")

rex.action{
  name = "cwd_debug", title = "Debug: Focused Terminal Directory",
  description = "Shows the raw results of the terminal's pwd and process methods, and the resolved path.",
  category = "Tom", keywords = "cwd pwd directory debug",
  run = function(ctx, args)
    local pwd, pwd_err = rex.block.call(util.TERMINAL, "pwd", {})
    local proc, proc_err = rex.block.call(util.TERMINAL, "process", {})
    local path, source = repo.focused_cwd()
    local result = { block_id = ctx.block_id, pwd = pwd, pwd_error = pwd_err, process = proc,
                     process_error = proc_err, resolved = path, source = source,
                     repo = path and repo.git_toplevel(path) or nil }
    rex.log("info", "cwd_debug: " .. (rex.json.encode(result) or "?"))
    return result
  end,
}
