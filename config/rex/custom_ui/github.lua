-- pr_checkout: pick an open PR (gh) and type `gh pr checkout N` into the terminal.

local util = require "custom_ui.util"
local repo = require "custom_ui.repo"

-- Summarise statusCheckRollup. Entries are CheckRun ({status, conclusion}) or StatusContext
-- ({state}) objects as printed by `gh pr list --json statusCheckRollup`.
local BAD = {
  FAILURE = true,
  ERROR = true,
  TIMED_OUT = true,
  CANCELLED = true,
  ACTION_REQUIRED = true,
  STARTUP_FAILURE = true,
}
local WAIT = { PENDING = true, EXPECTED = true, QUEUED = true, IN_PROGRESS = true, WAITING = true, REQUESTED = true }

local function ci_state(rollup)
  if type(rollup) ~= "table" or #rollup == 0 then
    return "- no CI"
  end
  local pending = false
  for _, c in ipairs(rollup) do
    if BAD[c.conclusion] or BAD[c.state] then
      return "✗ CI failing"
    end
    if WAIT[c.state] or (c.status and c.status ~= "COMPLETED") then
      pending = true
    end
  end
  return pending and "… CI running" or "✓ CI passing"
end

rex.action {
  name = "pr_checkout",
  title = "GitHub: Check Out PR…",
  description = "List open PRs in the focused terminal's repo (gh) and run `gh pr checkout N` in it.",
  category = "Tom",
  keywords = "gh pull request pr checkout review",
  args = { dir = "string?", number = "integer?" },
  run = function(_, args)
    local dir, why = repo.resolve_repo(args, "PR checkout")
    if dir == nil then
      return util.bail("pr_checkout", why)
    end

    local n = args.number and tostring(args.number)
    if n == nil then
      local out, err = util.exec_out({
        "gh",
        "pr",
        "list",
        "--state",
        "open",
        "--limit",
        tostring(util.config.pr_limit),
        "--json",
        "number,title,headRefName,labels,statusCheckRollup,isDraft",
      }, { cwd = dir, timeout = 25 })
      if out == nil then
        error(err, 0)
      end
      local prs, jerr = rex.json.decode(out)
      if prs == nil then
        error("couldn't read gh output: " .. tostring(jerr), 0)
      end
      if #prs == 0 then
        rex.log("info", "pr_checkout: no open PRs in " .. util.shorten(dir))
        return { count = 0 }
      end

      local items = {}
      for _, pr in ipairs(prs) do
        local labels = {}
        for _, l in ipairs(pr.labels or {}) do
          labels[#labels + 1] = l.name
        end
        local sub = pr.headRefName or ""
        if #labels > 0 then
          sub = sub .. "  ·  " .. table.concat(labels, ", ")
        end
        items[#items + 1] = {
          id = tostring(pr.number),
          title = (pr.isDraft and "[draft] " or "") .. (pr.title or ""),
          subtitle = sub,
          icon = "branch",
          detail = "#" .. pr.number .. " " .. ci_state(pr.statusCheckRollup),
        }
      end

      local pick, pwhy = rex.ui.pick {
        title = "Check out PR — " .. util.basename(dir),
        placeholder = "Filter PRs",
        items = items,
      }
      if pick == nil then
        return util.bail("pr_checkout", pwhy)
      end
      n = pick
    end

    if not n:match "^%d+$" then
      error("not a PR number: " .. n, 0)
    end
    -- Types the command into the terminal this action was run from, as if typed. It assumes that
    -- terminal is at a shell prompt in the repo.
    local _, werr = rex.block.call(util.TERMINAL, "write", { data = "gh pr checkout " .. n .. "\r" })
    if werr ~= nil then
      error("couldn't type into the terminal: " .. tostring(werr), 0)
    end
    return { pr = tonumber(n), repo = dir }
  end,
}
