-- Confirm helper + confirm_deploy, an approve-from-your-phone example that `rex do` can wait on.

local util = require("custom_ui.util")

local M = {}

-- M.confirm{ title, subtitle, yes, no, timeout } -> true | false, reason
--   Shows a two-row prompt in every connected Rex app (Mac and iOS) and returns true only when
--   "yes" is chosen. On false, `reason` is "declined", "cancelled", "timeout", "no_client",
--   "unsupported", "busy" or "failed" (the rex.ui reasons). `timeout` is seconds (default 300,
--   max 3600). "No" is listed first so a stray Return is the safe answer.
--   Like rex.ui.pick it only works when called directly inside an action's run — not in pcall,
--   a key-bound function, or a rex.on handler.
function M.confirm(opts)
  opts = opts or {}
  local answer, why = rex.ui.pick{
    title   = opts.title or "Are you sure?",
    timeout = opts.timeout and math.min(opts.timeout, 3600) or nil,
    items = {
      { id = "no",  title = opts.no  or "No",  subtitle = opts.subtitle, icon = "clock" },
      { id = "yes", title = opts.yes or "Yes", subtitle = opts.subtitle, icon = "star" },
    },
  }
  if answer == nil then return false, why end
  if answer == "yes" then return true end
  return false, "declined"
end

-- Headless friendly:
--   rex do confirm_deploy target=staging timeout=600 --timeout 10m   # asks on your phone/Mac, waits
--   rex do confirm_deploy target=staging yes=true                     # skips the prompt (CI)
--   rex do confirm_deploy target=staging && ./deploy.sh               # exit status 1 if not approved
--   rex do confirm_deploy dir=/Users/tombell/Code/app --args '{"cmd":["make","deploy"]}'
-- Run from the CLI/API/a script, a "no"/timeout makes the action fail so `&&` chains stop; from
-- the palette or a key it just logs. `cmd`, if given, runs after approval (25 s cap, since an
-- action has 30 s — use rex.exec.start with detach = true for anything longer).
rex.action{
  name = "confirm_deploy", title = "Deploy: Ask for Approval…",
  description = "Example: prompts \"Deploy to <target>?\" in every connected Rex app; `rex do` waits.",
  category = "Tom", keywords = "deploy approve confirm ship phone",
  args = { target = "string?", yes = "boolean?", timeout = "number?", dir = "string?", cmd = "array?" },
  run = function(ctx, args)
    local target = args.target or "production"
    local approved, why = true, nil
    if not args.yes then
      approved, why = M.confirm{
        title = "Deploy to " .. target .. "?", subtitle = "Approve from any connected Rex app",
        yes = "Ship it", no = "Not yet", timeout = args.timeout,
      }
    end
    if not approved then
      local msg = "deploy to " .. target .. " not approved (" .. tostring(why) .. ")"
      rex.log("warn", msg)
      if ctx.origin == "cli" or ctx.origin == "api" or ctx.origin == "script" then error(msg, 0) end
      return { approved = false, reason = why }
    end
    if args.cmd then
      local out, err = util.exec_out(args.cmd, { cwd = args.dir, timeout = 25 })
      if out == nil then error(err, 0) end
      return { approved = true, target = target, output = out }
    end
    rex.log("info", "deploy to " .. target .. " approved")
    return { approved = true, target = target }
  end,
}

return M
