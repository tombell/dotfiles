// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

const ctrlShift = ["ctrl", "shift"];
const ctrlOpt = ["ctrl", "opt"];
const ctrlShiftOpt = ["ctrl", "shift", "opt"];

const padding = 12;
const gap = 12;

// -----------------------------------------------------------------------------
// WINDOW MANAGEMENT
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

// Centre full
Keymap.on("c", ctrlShift, () => grid(12, 10, 12, 10, 0, 0));

// Centre medium
Keymap.on("x", ctrlShift, () => grid(12, 10, 10, 8, 1, 1));

// Centre medium, full height
Keymap.on("x", ctrlShiftOpt, () => grid(12, 10, 8, 10, 2, 0));

// Centre small
Keymap.on("z", ctrlShift, () => grid(12, 10, 8, 6, 2, 2));

// Centre small, full height
Keymap.on("z", ctrlShiftOpt, () => grid(12, 10, 6, 10, 3, 0));

// Left-half
Keymap.on("h", ctrlShift, () => grid(12, 10, 6, 10, 0, 0));

// Right-half
Keymap.on("l", ctrlShift, () => grid(12, 10, 6, 10, 6, 0));

// Left-one third
Keymap.on("h", ctrlOpt, () => grid(12, 10, 4, 10, 0, 0));

// Right-one third
Keymap.on("l", ctrlOpt, () => grid(12, 10, 4, 10, 8, 0));

// Left-two thirds
Keymap.on("h", ctrlShiftOpt, () => grid(12, 10, 8, 10, 0, 0));

// Right-two thirds
Keymap.on("l", ctrlShiftOpt, () => grid(12, 10, 8, 10, 4, 0));

const menuBarOffset = (screen) =>
  screen.flippedFrame.height - screen.flippedVisibleFrame.height;

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
    const offset = menuBarOffset(primary);
    newY += offset;
    newHeight -= offset;
  } else if (direction === "right" && win.screen.id === primary.id) {
    deltaX = win.screen.flippedVisibleFrame.width;
    const offset = menuBarOffset(primary);
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

// Move window to primary display
Keymap.on("left", ctrlShift, () => moveWindowToScreen("left"));

// Move window to secondary display
Keymap.on("right", ctrlShift, () => moveWindowToScreen("right"));
