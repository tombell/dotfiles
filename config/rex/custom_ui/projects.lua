-- project_switch: open a repo under ~/Code in a new tab.

local util = require "custom_ui.util"
local repo = require "custom_ui.repo"

rex.action {
  name = "project_switch",
  title = "Projects: Open Repo in New Tab…",
  description = "Pick a git repo under ~/Code (two levels deep) and open a shell tab there.",
  category = "Tom",
  keywords = "repo project folder code open cd",
  args = { dir = "string?" }, -- headless: rex do project_switch dir=/Users/tombell/Code/starkwm/swm
  run = function(_, args)
    local dir = args.dir
    if dir == nil then
      local why
      dir, why = repo.pick_repo "Open project"
      if dir == nil then
        return util.bail("project_switch", why)
      end
    end
    local w = util.open_dir(dir, util.basename(dir))
    return { window_id = w.window_id, dir = dir }
  end,
}
