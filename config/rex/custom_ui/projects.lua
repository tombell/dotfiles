-- project_switch: switch to a session for a repo under ~/Code, creating it if needed.
-- project_open: open a repo under ~/Code in a new tab.

local util = require "custom_ui.util"
local repo = require "custom_ui.repo"

-- The session labelled `name`, or nil.
local function find_session(name)
  local r, err = rex.call("session.list", {})
  if r == nil then
    error("couldn't list sessions: " .. tostring(err), 0)
  end
  for _, s in ipairs(r.sessions or {}) do
    if s.label == name then
      return s.session_id
    end
  end
end

local function create_session(name, dir)
  local r, err = rex.call("session.create", {
    label = name,
    initial_windows = {
      { window_label = name, layout = rex.layout.block { flavor = util.SHELL, options = { cwd = dir } } },
    },
  })
  if r == nil then
    error("couldn't create a session for " .. dir .. ": " .. tostring(err), 0)
  end
  return r.session_id
end

-- args.dir, or the repo picked from ~/Code (nil if cancelled).
local function project_dir(action, args)
  if args.dir then
    return args.dir
  end
  local dir, why = repo.pick_repo "Open project"
  if dir == nil then
    return util.bail(action, why)
  end
  return dir
end

rex.action {
  name = "project_switch",
  title = "Projects: Open Repo in Session…",
  description = "Pick a git repo under ~/Code (two levels deep) and switch to a session named after it, "
    .. "creating the session if there isn't one.",
  category = "Tom",
  keywords = "repo project folder code open session switch",
  args = { dir = "string?" }, -- headless: rex do project_switch dir=/Users/tombell/Code/starkwm/swm
  run = function(_, args)
    local dir = project_dir("project_switch", args)
    if dir == nil then
      return
    end
    local name = util.basename(dir):sub(1, 128)
    local id = find_session(name)
    local created = id == nil
    if created then
      id = create_session(name, dir)
    end
    rex.client.queue("session.select", { session_id = id })
    return { session_id = id, dir = dir, created = created }
  end,
}

rex.action {
  name = "project_open",
  title = "Projects: Open Repo in New Tab…",
  description = "Pick a git repo under ~/Code (two levels deep) and open a shell tab there.",
  category = "Tom",
  keywords = "repo project folder code open tab cd",
  args = { dir = "string?" },
  run = function(ctx, args)
    local dir = project_dir("project_open", args)
    if dir == nil then
      return
    end
    local w = util.open_dir(ctx, dir, util.basename(dir))
    return { window_id = w.window_id, dir = dir }
  end,
}
