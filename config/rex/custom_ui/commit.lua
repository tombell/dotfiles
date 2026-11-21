-- stage_commit: multi-select changed files, ask for a message, git add + git commit.

local util = require("custom_ui.util")
local repo = require("custom_ui.repo")

-- `git status --porcelain=v1 -z` (NUL-separated, so spaces/unicode in paths are safe). Renames and
-- copies (R/C in the first column) are followed by an extra NUL-terminated "original path" entry.
local function parse_status(text)
  local entries, pos = {}, 1
  local function nextfield()
    local stop = text:find("\0", pos, true)
    if not stop then return nil end
    local field = text:sub(pos, stop - 1)
    pos = stop + 1
    return field
  end
  while pos <= #text do
    local field = nextfield()
    if not field then break end
    if #field >= 4 then
      local x, y, path = field:sub(1, 1), field:sub(2, 2), field:sub(4)
      if x == "R" or x == "C" then nextfield() end
      entries[#entries + 1] = { x = x, y = y, path = path }
    end
  end
  return entries
end

local function describe_status(e)
  local x, y = e.x, e.y
  if x == "?" then return "new" end
  if x == "U" or y == "U" or (x == "A" and y == "A") or (x == "D" and y == "D") then return "conflict" end
  if x == "R" then return y == "M" and "renamed+mod" or "renamed" end
  if x == "D" or y == "D" then return "deleted" end
  if x ~= " " and y ~= " " then return "staged+mod" end
  if x ~= " " then return "staged" end
  return "modified"
end

rex.action{
  name = "stage_commit", title = "Git: Stage & Commit…",
  description = "Tick changed files, type a message, then git add + git commit in the repo. " ..
                "Anything already staged is committed too.",
  category = "Tom", keywords = "git add commit stage status",
  args = { dir = "string?", message = "string?", files = "array?" },
  run = function(ctx, args)
    local root, why = repo.resolve_repo(args, "Commit")
    if root == nil then return util.bail("stage_commit", why) end
    local name = util.basename(root)

    local out, err = util.exec_out({ "git", "status", "--porcelain=v1", "-z", "--untracked-files=all" },
                                   { cwd = root, timeout = 15 })
    if out == nil then error(err, 0) end
    local entries = parse_status(out)
    if #entries == 0 then
      rex.log("info", "stage_commit: nothing to commit in " .. util.shorten(root))
      return { committed = false, reason = "clean" }
    end

    -- Which files to stage.
    local chosen = args.files
    if chosen == nil then
      local items = {}
      for _, e in ipairs(entries) do   -- nothing is pre-ticked (no `selected = true`)
        local dir = e.path:match("^(.*)/[^/]*$")
        items[#items + 1] = {
          id = e.path, title = util.basename(e.path), subtitle = dir, icon = "document",
          detail = describe_status(e),
        }
      end
      local pick, pwhy = rex.ui.pick{
        title = "Stage — " .. name .. "  (already-staged files are committed too)",
        placeholder = "Filter changed files", multiple = true, confirm = "Stage", items = items,
      }
      if pick == nil then return util.bail("stage_commit", pwhy) end
      chosen = pick
    end
    if #chosen == 0 then
      rex.log("info", "stage_commit: no files selected")
      return { committed = false, reason = "nothing selected" }
    end

    -- Commit message.
    local message = args.message
    if message == nil then
      local text, mwhy = rex.ui.input{
        title = "Commit message — " .. name,
        placeholder = "Summary line", confirm = "Commit",
      }
      if text == nil then return util.bail("stage_commit", mwhy) end
      message = text
    end
    message = util.trim(message)
    if message == "" then
      rex.log("warn", "stage_commit: empty commit message, nothing done")
      return { committed = false, reason = "empty message" }
    end

    -- Only files with unstaged work (or untracked) need `git add`; already-staged ones are skipped
    -- (re-adding a staged rename's old path would fail).
    local wanted, to_add = {}, {}
    for _, p in ipairs(chosen) do wanted[p] = true end
    for _, e in ipairs(entries) do
      if wanted[e.path] and (e.x == "?" or e.y ~= " ") then to_add[#to_add + 1] = e.path end
    end
    if #to_add > 0 then
      local argv = { "git", "add", "-A", "--" }
      for _, p in ipairs(to_add) do argv[#argv + 1] = p end
      local _, aerr = util.exec_out(argv, { cwd = root, timeout = 20 })
      if aerr then
        util.report("error", "git add failed", aerr)
        error(aerr, 0)
      end
    end

    local cout, cerr = util.exec_out({ "git", "commit", "-m", message }, { cwd = root, timeout = 25 })
    if cout == nil then
      util.report("error", "git commit failed — " .. name, util.first_line(cerr))
      error(cerr, 0)
    end
    local sha = util.trim(util.exec_out({ "git", "rev-parse", "--short", "HEAD" }, { cwd = root, timeout = 5 }))
    util.report("info", "Committed — " .. name, sha .. " " .. util.first_line(message))
    return { committed = true, repo = root, sha = sha, staged = to_add }
  end,
}
