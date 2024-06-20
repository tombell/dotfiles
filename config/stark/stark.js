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

  if (!win) {
    return;
  }

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

// Move window to previous display
Keymap.on("left", ctrlShift, () => {
  const win = Window.focused();

  // TODO: better check for detecting if not an the left most screen
  if (win && win.screen.id !== win.screen.previous.id) {
    const { x, y, width, height } = win.frame;

    const curr = win.screen.flippedVisibleFrame;
    const next = win.screen.previous.flippedVisibleFrame;

    const delta = curr.height - next.height;

    win.setFrame({
      width,
      height: height - delta,
      x: x - curr.width,
      y: y - delta,
    });
  }
});

// Move window to next display
Keymap.on("right", ctrlShift, () => {
  const win = Window.focused();

  // TODO: better check for detecting if not an the right most screen
  if (win && win.screen.id !== win.screen.next.id) {
    const { x, y, width, height } = win.frame;

    const curr = win.screen.flippedVisibleFrame;
    const next = win.screen.next.flippedVisibleFrame;

    const delta = next.height - curr.height;

    win.setFrame({
      width,
      height: height + delta,
      x: x + curr.width,
      y: y + delta,
    });
  }
});

// -----------------------------------------------------------------------------
// SPACES MANAGEMENT
// -----------------------------------------------------------------------------

[...Array(Space.all().length).keys()].forEach((i) => {
  const key = `${i + 1}`;

  Keymap.on(key, ctrlShift, () => {
    const win = Window.focused();

    if (win) {
      Space.at(i).moveWindow(win);
    }
  });

  Keymap.on(key, ctrlShiftOpt, () => {
    const win = Window.focused();

    if (win) {
      Space.at(i).moveWindow(win);
      win.focus();
    }
  });
});
