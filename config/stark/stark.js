// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

// Default modifier keys for binds
const MODIFIERS = ["ctrl", "shift"];

// Grid width and height for centering windows with different sizes
const GRID_WIDTH = 12;
const GRID_HEIGHT = 10;

// Margin to have around each window edge
const MARGIN = 16;

// -----------------------------------------------------------------------------
// WINDOW CENTERING
// -----------------------------------------------------------------------------

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

// -----------------------------------------------------------------------------
// SPACES MANAGEMENT
// -----------------------------------------------------------------------------

[...Array(Space.all().length).keys()].forEach((space) => {
  Bind.on(`${space + 1}`, MODIFIERS, () => {
    Space.all()[space].moveWindows([Window.focused()].filter(Boolean));
  });
});
