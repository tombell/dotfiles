// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

const MODIFIERS = ["⌃", "⇧"];
const FULL_MODIFIERS = MODIFIERS.concat(["⌥"]);

const GRID_WIDTH = 12;
const GRID_HEIGHT = 10;

const MARGIN = 16;

// -----------------------------------------------------------------------------
// WINDOW CENTERING
// -----------------------------------------------------------------------------

// Small
Bind.on("z", MODIFIERS, () => {
  const win = Window.focused();
  const { width, height, y } = win?.screen.frameWithoutDockOrMenu;

  win?.setFrame({
    x: (width / GRID_WIDTH) * 2,
    y: y + (height / GRID_HEIGHT) * 2,
    width: (width / GRID_WIDTH) * 8,
    height: (height / GRID_HEIGHT) * 6,
  });
});

// Medium
Bind.on("x", MODIFIERS, () => {
  const win = Window.focused();
  const { width, height, y } = win?.screen.frameWithoutDockOrMenu;

  win?.setFrame({
    x: width / GRID_WIDTH,
    y: y + height / GRID_HEIGHT,
    width: (width / GRID_WIDTH) * 10,
    height: (height / GRID_HEIGHT) * 8,
  });
});

// Full
Bind.on("c", MODIFIERS, () => {
  const win = Window.focused();
  const { width, height, x, y } = win?.screen.frameWithoutDockOrMenu;

  win?.setFrame({
    x: x + MARGIN,
    y: y + MARGIN,
    width: width - MARGIN * 2,
    height: height - MARGIN * 2,
  });
});

// -----------------------------------------------------------------------------
// WINDOW POSITIONING
// -----------------------------------------------------------------------------

// Left-half
Bind.on("h", MODIFIERS, () => {
  const win = Window.focused();
  const { width, height, x, y } = win?.screen.frameWithoutDockOrMenu;

  win?.setFrame({
    x: x + MARGIN,
    y: y + MARGIN,
    width: width / 2 - (MARGIN + MARGIN / 2),
    height: height - MARGIN * 2,
  });
});

// Left-two thirds
Bind.on("h", FULL_MODIFIERS, () => {
  const win = Window.focused();
  const { width, height, x, y } = win?.screen.frameWithoutDockOrMenu;

  win?.setFrame({
    x: x + MARGIN,
    y: y + MARGIN,
    width: ((width / 3) * 2) - (MARGIN + MARGIN / 2),
    height: height - MARGIN * 2,
  });
});

// Right-half
Bind.on("l", MODIFIERS, () => {
  const win = Window.focused();
  const { width, height, x, y } = win?.screen.frameWithoutDockOrMenu;

  win?.setFrame({
    x: x + width / 2 + MARGIN / 2,
    y: y + MARGIN,
    width: width / 2 - (MARGIN + MARGIN / 2),
    height: height - MARGIN * 2,
  });
});

// Right-one third
Bind.on("l", FULL_MODIFIERS, () => {
  const win = Window.focused();
  const { width, height, x, y } = win?.screen.frameWithoutDockOrMenu;

  win?.setFrame({
    x: x + ((width / 3) * 2) + MARGIN / 2,
    y: y + MARGIN,
    width: (width / 3) - (MARGIN + MARGIN / 2),
    height: height - MARGIN * 2,
  });
});

// -----------------------------------------------------------------------------
// SPACES MANAGEMENT
// -----------------------------------------------------------------------------

[...Array(Space.all().length).keys()].forEach((space) => {
  Bind.on(`${space + 1}`, MODIFIERS, () => {
    Space.all()[space].moveWindows([Window.focused()].filter(Boolean));
  });
});
