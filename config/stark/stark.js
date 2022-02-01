// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

// Default modifier keys for binds
const MODIFIERS = ["ctrl", "shift"];

// Grid width and height for centering windows with different sizes
const GRID_WIDTH = 12;
const GRID_HEIGHT = 10;

// Margin to have around each window edge
const MARGIN = 14;

// -----------------------------------------------------------------------------
// WINDOW CENTERING
// -----------------------------------------------------------------------------

Bind.on("z", MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;
  const x = (r.width / GRID_WIDTH) * 2;
  const y = r.y + (r.height / GRID_HEIGHT) * 2;
  const width = (r.width / GRID_WIDTH) * 8;
  const height = (r.height / GRID_HEIGHT) * 6;

  win.setFrame({ x, y, width, height });
});

Bind.on("x", MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;
  const x = r.width / GRID_WIDTH;
  const y = r.y + r.height / GRID_HEIGHT;
  const width = (r.width / GRID_WIDTH) * 10;
  const height = (r.height / GRID_HEIGHT) * 8;

  win.setFrame({ x, y, width, height });
});

Bind.on("c", MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;
  const x = r.x + MARGIN;
  const y = r.y + MARGIN;
  const width = r.width - MARGIN * 2;
  const height = r.height - MARGIN * 2;

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------
// WINDOW POSITIONING
// -----------------------------------------------------------------------------

Bind.on("h", MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;
  const x = r.x + MARGIN;
  const y = r.y + MARGIN;
  const width = r.width / 2 - (MARGIN + MARGIN / 2);
  const height = r.height - MARGIN * 2;

  win.setFrame({ x, y, width, height });
});

Bind.on("l", MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;
  const x = r.x + r.width / 2 + MARGIN / 2;
  const y = r.y + MARGIN;
  const width = r.width / 2 - (MARGIN + MARGIN / 2);
  const height = r.height - MARGIN * 2;

  win.setFrame({ x, y, width, height });
});

Bind.on("j", MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;
  const x = r.x + MARGIN;
  const y = r.y + MARGIN;
  const width = r.width / 2 - (MARGIN + MARGIN / 2);
  const height = r.height / 2 - (MARGIN + MARGIN / 2);

  win.setFrame({ x, y, width, height });
});

Bind.on("k", MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;
  const x = r.x + r.width / 2 + MARGIN / 2;
  const y = r.y + MARGIN;
  const width = r.width / 2 - (MARGIN + MARGIN / 2);
  const height = r.height / 2 - (MARGIN + MARGIN / 2);

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------
// SPACES MANAGEMENT
// -----------------------------------------------------------------------------

const numOfSpaces = Space.all().length;
const spaces = [...Array(numOfSpaces).keys()].map(i => i + 1);

spaces.forEach(space => {
  Bind.on(`${space}`, MODIFIERS, () => {
    const win = Window.focused();

    if (!win) {
      return;
    }

    Space.all()[space - 1].moveWindows([win]);
  });
});
