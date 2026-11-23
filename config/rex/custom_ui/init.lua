-- custom_ui — Rex custom actions for Tom (Lua 5.1, loaded by Rex's init.lua).
--
-- Each feature lives in its own file in this directory (all actions appear in the command
-- palette; `rex actions` lists them):
--   util.lua       shared config (M.config) and helpers
--   repo.lua       focused terminal's directory, repo discovery/picking
--   projects.lua   project_switch   Open a repo under ~/Code in a new tab
--   github.lua     pr_checkout      Pick an open PR (gh) and type `gh pr checkout N` into the terminal
--   worktrees.lua  worktree_jump    Pick a git worktree and open it in a new tab
--
-- Install: link this directory to ~/.config/rex/custom_ui, then in ~/.config/rex/init.lua:
--   require("custom_ui").bind_defaults()   -- or just require("custom_ui") and bind keys yourself
--   -- then:  rex config check && rex config reload

local util = require "custom_ui.util"

require "custom_ui.projects"
require "custom_ui.github"
require "custom_ui.worktrees"

local M = {}
M.config = util.config

----------------------------------------------------------------------------------------------
-- Key bindings
-- Rex's defaults use cmd, alt+cmd, shift+cmd, alt+shift+cmd and ctrl+cmd+{f,i}; none uses
-- ctrl+alt+cmd. These are unbound until you call require("custom_ui").bind_defaults().
-- (If skbd/swm hotkeys already use ctrl+alt+cmd+<letter>, change them here — they are only
-- checked against Rex's own defaults.)
----------------------------------------------------------------------------------------------
function M.bind_defaults()
  rex.bind("ctrl+alt+cmd+p", "project_switch") -- [P]rojects
  rex.bind("ctrl+alt+cmd+r", "pr_checkout") -- PR / [R]eview
  rex.bind("ctrl+alt+cmd+w", "worktree_jump") -- [W]orktrees
end

return M
