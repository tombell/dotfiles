-- worktree_jump: pick a git worktree and open it in a new tab.

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

rex.action {
  name = "worktree_jump",
  title = "Git: Jump to Worktree…",
  description = "Pick one of the repo's git worktrees and open a shell tab there.",
  category = "Tom",
  keywords = "git worktree branch jump t3",
  args = { dir = "string?" },
  run = function(_, args)
    local root, why = repo.resolve_repo(args, "Worktrees")
    if root == nil then
      return util.bail("worktree_jump", why)
    end
    local out, err = util.exec_out({ "git", "worktree", "list", "--porcelain" }, { cwd = root, timeout = 10 })
    if out == nil then
      error(err, 0)
    end
    local trees = parse_worktrees(out)
    if #trees == 0 then
      rex.log("info", "worktree_jump: no worktrees for " .. util.shorten(root))
      return { count = 0 }
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
      return util.bail("worktree_jump", pwhy)
    end
    local w = util.open_dir(dir, label[dir])
    return { window_id = w.window_id, dir = dir }
  end,
}
