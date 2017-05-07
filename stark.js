// -----------------------------------------------------------------------------
// VARIABLES
// -----------------------------------------------------------------------------

// Default modifier keys for binds
const MODIFIERS = ['ctrl', 'shift']

// Grid width and height for centering windows with different sizes
const GRID_WIDTH = 12
const GRID_HEIGHT = 10

// Margin to have around each window edge
const MARGIN = 10

// -----------------------------------------------------------------------------
// FUNCTIONS
// -----------------------------------------------------------------------------

Bind.on("s", MODIFIERS, () => {
  Stark.run("/usr/bin/open", [
    "/System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app"
  ]);
});

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

// -----------------------------------------------------------------------------

Bind.on("x", MODIFIERS, () => {
  const win = Window.focused();
  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const x = r.width / GRID_WIDTH;
  const y = r.y + (r.height / GRID_HEIGHT);

  const width = (r.width / GRID_WIDTH) * 10;
  const height = (r.height / GRID_HEIGHT) * 8;

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

Bind.on("c", MODIFIERS, () => {
  const win = Window.focused();
  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const x = r.x + MARGIN;
  const y = r.y + MARGIN;

  const width = r.width - (MARGIN * 2);
  const height = r.height - (MARGIN * 2);

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

Bind.on("f", MODIFIERS, () => {
  const win = Window.focused();
  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const width = r.width / 2;
  const height = r.height - (MARGIN * 2);

  const x = r.x + (width / 2);
  const y = r.y + MARGIN;

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

Bind.on("h", MODIFIERS, () => {
  const win = Window.focused();
  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const x = r.x + MARGIN;
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height - (MARGIN * 2);

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

Bind.on("l", MODIFIERS, () => {
  const win = Window.focused();
  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const x = (r.x + (r.width / 2)) + (MARGIN / 2);
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height - (MARGIN * 2);

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

Bind.on("j", MODIFIERS, () => {
  const win = Window.focused();
  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const x = r.x + MARGIN;
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height / 2 - (MARGIN + (MARGIN / 2));

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

Bind.on("k", MODIFIERS, () => {
  const win = Window.focused();
  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const x = (r.x + (r.width / 2)) + (MARGIN / 2);
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height / 2 - (MARGIN + (MARGIN / 2));

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

Bind.on("t", MODIFIERS, () => {
  const app = App.find("Tweetbot");
  if (!app) {
    return;
  }

  _.each(app.windows(), (win) => {
    const r = win.screen.frameWithoutDockOrMenu;

    const x = r.x + MARGIN;
    const y = r.y + MARGIN;

    const width = r.width / 4 - (MARGIN + (MARGIN / 2));
    const height = r.height - (MARGIN * 2);

    win.setFrame({ x, y, width, height });
  });
});

// -----------------------------------------------------------------------------
