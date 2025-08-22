// Modifier combinations
// -----------------------------------------------------------------------------

const ctrlShift = ["ctrl", "shift"];
const ctrlOpt = ["ctrl", "opt"];
const ctrlShiftOpt = ["ctrl", "shift", "opt"];
const shiftOpt = ["shift", "opt"];

// Window gaps
// -----------------------------------------------------------------------------

// The space between window and screen edge
const padding = 12;

// The space between windows
const gap = 12;

// Move and reize window
// -----------------------------------------------------------------------------

const grid = (c, r, w, h, x, y) => {
  const win = Window.focused();
  if (!win) return;

  if (x >= c) x = c - 1;
  if (y >= r) y = r - 1;

  if (w <= 0) w = 1;
  if (h <= 0) h = 1;

  if (w > c - x) w = c - x;
  if (h > r - y) h = r - y;

  const bounds = win.screen.flippedVisibleFrame;

  bounds.x += padding;
  bounds.width -= padding * 2;
  bounds.y += padding;
  bounds.height -= padding * 2;

  if (x > 0) {
    bounds.x += gap;
    bounds.width -= gap;
  }

  if (y > 0) {
    bounds.y += gap;
    bounds.height -= gap;
  }

  if (c > x + w) bounds.width -= gap;
  if (r > y + h) bounds.height -= gap;

  const cw = bounds.width / c;
  const ch = bounds.height / r;
  const fx = bounds.x + bounds.width - cw * (c - x);
  const fy = bounds.y + bounds.height - ch * (r - y);
  const fw = cw * w;
  const fh = ch * h;

  win.setFrame({ x: fx, y: fy, width: fw, height: fh });
};

const moveAndResizeWindow = (key, mods, ...args) =>
  Keymap.on(key, mods, () => grid(...args));

moveAndResizeWindow("c", ctrlShift, 12, 10, 12, 10, 0, 0); // Centre full
moveAndResizeWindow("x", ctrlShift, 12, 10, 10, 8, 1, 1); // Centre medium
moveAndResizeWindow("x", ctrlShiftOpt, 12, 10, 8, 10, 2, 0); // Centre medium, full height
moveAndResizeWindow("z", ctrlShift, 12, 10, 8, 6, 2, 2); // Centre small
moveAndResizeWindow("z", ctrlShiftOpt, 12, 10, 6, 10, 3, 0); // Centre small, full height

moveAndResizeWindow("h", ctrlOpt, 12, 10, 4, 10, 0, 0); // Left-one third
moveAndResizeWindow("h", ctrlShift, 12, 10, 6, 10, 0, 0); // Left-half
moveAndResizeWindow("h", ctrlShiftOpt, 12, 10, 8, 10, 0, 0); // Left-two thirds

moveAndResizeWindow("l", ctrlOpt, 12, 10, 4, 10, 8, 0); // Right-one third
moveAndResizeWindow("l", ctrlShift, 12, 10, 6, 10, 6, 0); // Right-half
moveAndResizeWindow("l", ctrlShiftOpt, 12, 10, 8, 10, 4, 0); // Right-two thirds

// Move windows to screen
// -----------------------------------------------------------------------------

const moveWindowToScreen = (direction) => {
  const win = Window.focused();
  if (!win) return;

  const [primary, secondary] = Screen.all();
  const { x, y, width, height } = win.frame;

  let deltaX = 0;
  let newY = y;
  let newHeight = height;

  if (direction === "left" && win.screen.id === secondary.id) {
    deltaX = -win.screen.flippedVisibleFrame.width;
    const offset =
      primary.flippedFrame.height - primary.flippedVisibleFrame.height;
    newY += offset;
    newHeight -= offset;
  } else if (direction === "right" && win.screen.id === primary.id) {
    deltaX = win.screen.flippedVisibleFrame.width;
    const offset =
      secondary.flippedFrame.height - secondary.flippedVisibleFrame.height;
    newY -= offset;
    newHeight += offset;
  }

  win.setFrame({
    x: x + deltaX,
    y: newY,
    width,
    height: newHeight,
  });
};

Keymap.on("left", ctrlShift, () => moveWindowToScreen("left"));
Keymap.on("right", ctrlShift, () => moveWindowToScreen("right"));

// Nudge windows
// -----------------------------------------------------------------------------

const nudgeWindow = (dx, dy) => {
  const win = Window.focused();
  if (!win) return;
  const { x, y, width, height } = win.frame;
  win.setFrame({ x: x + dx, y: y + dy, width, height });
};

Keymap.on("h", shiftOpt, () => nudgeWindow(-10, 0));
Keymap.on("j", shiftOpt, () => nudgeWindow(0, 10));
Keymap.on("k", shiftOpt, () => nudgeWindow(0, -10));
Keymap.on("l", shiftOpt, () => nudgeWindow(10, 0));
