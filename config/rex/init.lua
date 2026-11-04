rex.action {
  name = "session_picker",
  title = "Find Session…",
  description = "Fuzzy find a session with fzf and switch to it.",
  category = "Sessions",
  keywords = "fzf fuzzy find switch session",
  run = function(ctx)
    local command = { "rex-sessions" }
    if ctx.client_id ~= nil then
      table.insert(command, ctx.client_id)
    end

    local _, err = rex.session.new_layer {
      bounds = { 0.2, 0.2, 0.6, 0.5 },
      focus = true,
      layout = rex.layout.block {
        flavor = "com.superlogical.terminal.shell",
        options = { command = command },
      },
    }
    if err ~= nil then
      error(err, 0)
    end
  end,
}

rex.bind("cmd+shift+k", "session_picker")
