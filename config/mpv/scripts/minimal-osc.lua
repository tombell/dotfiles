local mp = require "mp"
local assdraw = require "mp.assdraw"

local opts = {
  height = 70,
  margin = 60,
  bar_height = 6,
  title_size = 30,
  time_size = 28,
  hide_delay = 1.0,
}

-- Sagittarius A palette. ASS colours use BGR rather than RGB.
local colours = {
  title = "&HC2F1FF&", -- #FFF1C2
  time = "&HC4D9F4&", -- #F4D9C4
  outline = "&H1C1011&", -- #11101C
  track = "&H94829B&", -- #9B8294
  progress = "&H9DB4F2&", -- #F2B49D
}

local overlay = mp.create_osd_overlay "ass-events"
local visible = false
local dragging = false
local seeking = false
local hovering = false

local function clamp(value)
  return math.max(0, math.min(1, value))
end

local function geometry()
  local w, h = mp.get_osd_size()
  return {
    x1 = opts.margin,
    x2 = w - opts.margin,
    y = h - opts.height,
    width = w - 2 * opts.margin,
  }
end

local function mouse_over_bar()
  local x, y = mp.get_mouse_pos()
  local g = geometry()
  return x >= g.x1 and x <= g.x2 and y >= g.y - 12 and y <= g.y + opts.bar_height + 12
end

local function seek_from_mouse()
  local x = mp.get_mouse_pos()
  local g = geometry()
  if g.width > 0 then
    mp.commandv("seek", clamp((x - g.x1) / g.width) * 100, "absolute-percent", "exact")
  end
end

local function format_time(seconds)
  if not seconds then
    return "--:--"
  end

  seconds = math.max(0, math.floor(seconds))
  local hours = math.floor(seconds / 3600)
  local minutes = math.floor(seconds / 60) % 60
  local remaining = seconds % 60
  if hours > 0 then
    return string.format("%d:%02d:%02d", hours, minutes, remaining)
  end
  return string.format("%d:%02d", minutes, remaining)
end

local function render()
  local w, h = mp.get_osd_size()
  if not visible or w <= 0 or h <= 0 then
    overlay:remove()
    return
  end

  -- Match ASS coordinates to window pixels and mouse coordinates.
  overlay.res_x, overlay.res_y = w, h
  local g = geometry()
  local ass = assdraw.ass_new()

  local function text(alignment, x, y, size, colour, value)
    ass:new_event()
    ass:append(
      string.format(
        "{\\an%d\\pos(%f,%f)\\fs%d\\bord1\\shad0\\1c%s\\3c%s}%s",
        alignment,
        x,
        y,
        size,
        colour,
        colours.outline,
        value
      )
    )
  end

  local function bar(x2, style)
    ass:new_event()
    ass:append("{\\an7\\pos(0,0)\\bord0\\shad0" .. style .. "}")
    ass:draw_start()
    ass:rect_cw(g.x1, g.y, x2, g.y + opts.bar_height)
    ass:draw_stop()
  end

  local title = mp.get_property("media-title", "")
  title = title:gsub("\\", "\\\\"):gsub("{", "\\{"):gsub("}", "\\}")
  text(2, (g.x1 + g.x2) / 2, g.y - 18, opts.title_size, colours.title, title)

  local progress = clamp(mp.get_property_number("percent-pos", 0) / 100)
  bar(g.x2, "\\1c" .. colours.track .. "\\alpha&H60&")
  bar(g.x1 + g.width * progress, "\\1c" .. colours.progress)

  local time_y = g.y + opts.bar_height + 10
  text(7, g.x1, time_y, opts.time_size, colours.time, format_time(mp.get_property_number "time-pos"))
  text(9, g.x2, time_y, opts.time_size, colours.time, format_time(mp.get_property_number "duration"))

  overlay.data = ass.text
  overlay:update()
end

local hide_timer = mp.add_timeout(opts.hide_delay, function()
  if dragging or seeking or hovering then
    return
  end
  visible = false
  render()
end)
hide_timer:kill()

local function schedule_hide()
  hide_timer:kill()
  if not dragging and not seeking and not hovering then
    hide_timer:resume()
  end
end

local function mouse_move()
  hovering = mouse_over_bar()
  if dragging then
    seek_from_mouse()
  end
  visible = true
  render()
  schedule_hide()
end

local function mouse_button(event)
  hovering = mouse_over_bar()
  if event.event == "down" and visible and mouse_over_bar() then
    dragging = true
    hide_timer:kill()
    seek_from_mouse()
    render()
  elseif event.event == "up" and dragging then
    seek_from_mouse()
    dragging = false
    schedule_hide()
  end
end

-- Show during mouse or keyboard seeks, then hide after the usual delay.
mp.observe_property("seeking", "bool", function(_, active)
  seeking = active == true
  if seeking then
    visible = true
    render()
  end
  if visible then
    schedule_hide()
  end
end)

mp.add_forced_key_binding("MOUSE_LEAVE", "minimal-osc-mouse-leave", function()
  hovering = false
  schedule_hide()
end)
mp.add_forced_key_binding("MOUSE_MOVE", "minimal-osc-mouse-move", mouse_move)
mp.add_forced_key_binding("MBTN_LEFT", "minimal-osc-seek", mouse_button, { complex = true })

local function redraw()
  if visible then
    render()
  end
end

for _, property in ipairs { "percent-pos", "time-pos", "duration", "media-title", "osd-width", "osd-height" } do
  mp.observe_property(property, "native", redraw)
end
