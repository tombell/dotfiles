local prefix = "ctrl+b"

local function seq(key, action, args)
  rex.bind(prefix .. ">" .. key, action, args)
end

-- Send a literal ctrl+b by pressing it twice.
seq(prefix, "pane.send_key", { key = prefix })

-- Sessions
seq("g", "session.switch")
seq("shift+n", "session.new")
seq("shift+w", "session.rename")
seq("shift+d", "session.close")
rex.bind("alt+shift+[", "session.previous")
rex.bind("alt+shift+]", "session.next")

-- Tabs
seq("c", "client.tab.new")
seq("n", "client.tab.next")
seq("p", "client.tab.previous")
seq("shift+t", "client.tab.rename")
seq("shift+x", "client.tab.close")

-- Panes
seq("t", "pane.go_to")
seq("v", "pane.split.right")
seq("-", "pane.split.down")
seq("x", "pane.close")
seq("z", "pane.zoom")
seq("shift+p", "pane.rename")
seq("tab", "pane.focus_next")
seq("shift+tab", "pane.focus_previous")

for key, dir in pairs { h = "left", j = "down", k = "up", l = "right" } do
  seq(key, "pane.focus." .. dir)
  seq("shift+" .. key, "pane.move." .. dir)
end

-- Misc
seq("b", "client.sidebar.toggle")
seq("s", "client.settings")

-- Custom UI actions
require "custom_ui"
seq("o", "project_switch") -- [o]pen project
seq("r", "pr_checkout") -- [r]eview PR
seq("w", "worktree_jump") -- [w]orktree, cd here
seq("alt+w", "worktree_open") -- [w]orktree in a new tab
