-- worktree_jump: pick a git worktree and cd to it in the focused terminal.
-- worktree_open: pick a git worktree and open it in a new tab.

local util = require "custom_ui.util"
local repo = require "custom_ui.repo"

local function parse_worktrees(text)
  local list = {}
  for block in (text .. "\n\n"):gmatch "(.-)\n\n" do
    local wt = {}
    for line in block:gmatch "[^\n]+" do
      local key, value = line:match "^(%S+)%s?(.*)$"
      if key then
        wt[key] = (value ~= "" and value) or true
      end
    end
    if wt.worktree and not wt.bare and not wt.prunable then
      list[#list + 1] = wt
    end
  end
  return list
end

-- Ask which worktree of the resolved repo to use. Returns its path and a tab label, or nil if
-- there's nothing to do (the reason is already logged).
local function pick_worktree(action, args)
  local root, why = repo.resolve_repo(args, "Worktrees")
  if root == nil then
    return util.bail(action, why)
  end
  local out, err = util.exec_out({ "git", "worktree", "list", "--porcelain" }, { cwd = root, timeout = 10 })
  if out == nil then
    error(err, 0)
  end
  local trees = parse_worktrees(out)
  if #trees == 0 then
    rex.log("info", action .. ": no worktrees for " .. util.shorten(root))
    return nil
  end

  local items, label = {}, {}
  for _, wt in ipairs(trees) do
    local branch = type(wt.branch) == "string" and wt.branch:gsub("^refs/heads/", "") or nil
    local name = branch or ("(detached) " .. util.basename(wt.worktree))
    local sha = type(wt.HEAD) == "string" and wt.HEAD:sub(1, 7) or ""
    items[#items + 1] = {
      id = wt.worktree,
      title = name,
      subtitle = util.shorten(wt.worktree),
      icon = "branch",
      detail = sha .. (wt.worktree == root and "  (here)" or "") .. (wt.locked and "  locked" or ""),
    }
    label[wt.worktree] = branch or util.basename(wt.worktree)
  end

  local dir, pwhy = rex.ui.pick {
    title = "Worktrees — " .. util.basename(root),
    placeholder = "Filter worktrees",
    items = items,
  }
  if dir == nil then
    return util.bail(action, pwhy)
  end
  return dir, label[dir]
end

rex.action {
  name = "worktree_jump",
  title = "Git: Jump to Worktree…",
  description = "Pick one of the repo's git worktrees and cd to it in the focused terminal.",
  category = "Tom",
  keywords = "git worktree branch jump cd t3",
  args = { dir = "string?" },
  run = function(_, args)
    local dir = pick_worktree("worktree_jump", args)
    if dir == nil then
      return
    end
    util.type_in_shell("cd " .. util.shell_quote(dir))
    return { dir = dir }
  end,
}

rex.action {
  name = "worktree_open",
  title = "Git: Open Worktree in New Tab…",
  description = "Pick one of the repo's git worktrees and open a shell tab there.",
  category = "Tom",
  keywords = "git worktree branch open tab t3",
  args = { dir = "string?" },
  run = function(ctx, args)
    local dir, label = pick_worktree("worktree_open", args)
    if dir == nil then
      return
    end
    local w = util.open_dir(ctx, dir, label)
    return { window_id = w.window_id, dir = dir }
  end,
}
