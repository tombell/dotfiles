// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

// Default modifier keys for binds
const MODIFIERS = ['ctrl', 'shift'];

// Default modifier keys for resizing windows binds
const RESIZE_MODIFIERS = ['shift', 'alt'];

// Default modifier keys for positioning windows binds.
const POSITION_MODIFIERS = ['ctrl', 'shift'];

// Grid width and height for centering windows with different sizes
const GRID_WIDTH = 12;
const GRID_HEIGHT = 10;

// Margin to have around each window edge
const MARGIN = 10;

// Size for resizing/positioning increments/decrements.
const RESIZE_POSITION_AMOUNT = 40;

// -----------------------------------------------------------------------------
// FUNCTIONS
// -----------------------------------------------------------------------------

Bind.on("s", MODIFIERS, () => {
  Stark.run("/usr/bin/open", ["/System/Library/CoreServices/ScreenSaverEngine.app"]);
});

// -----------------------------------------------------------------------------
// WINDOW MOVEMENT
// -----------------------------------------------------------------------------

Bind.on("up", POSITION_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const x = win.topLeft.x;
  const y = win.topLeft.y - RESIZE_POSITION_AMOUNT;

  win.setTopLeft({ x, y });
});

Bind.on("down", POSITION_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const x = win.topLeft.x;
  const y = win.topLeft.y + RESIZE_POSITION_AMOUNT;

  win.setTopLeft({ x, y });
});

Bind.on("left", POSITION_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const x = win.topLeft.x - RESIZE_POSITION_AMOUNT;
  const y = win.topLeft.y;

  win.setTopLeft({ x, y });
});

Bind.on("right", POSITION_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const x = win.topLeft.x + RESIZE_POSITION_AMOUNT;
  const y = win.topLeft.y;

  win.setTopLeft({ x, y });
});

// -----------------------------------------------------------------------------
// WINDOW RESIZING
// -----------------------------------------------------------------------------

Bind.on("up", RESIZE_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const width = win.size.width;
  const height = win.size.height - RESIZE_POSITION_AMOUNT;

  win.setSize({ width, height });
});

Bind.on("down", RESIZE_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const width = win.size.width;
  const height = win.size.height + RESIZE_POSITION_AMOUNT;

  win.setSize({ width, height });
});

Bind.on("left", RESIZE_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const width = win.size.width - RESIZE_POSITION_AMOUNT;
  const height = win.size.height;

  win.setSize({ width, height });
});

Bind.on("right", RESIZE_MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const width = win.size.width + RESIZE_POSITION_AMOUNT;
  const height = win.size.height;

  win.setSize({ width, height });
});

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
  const y = r.y + (r.height / GRID_HEIGHT);

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

  const width = r.width - (MARGIN * 2);
  const height = r.height - (MARGIN * 2);

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

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height - (MARGIN * 2);

  win.setFrame({ x, y, width, height });
});

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
// APP EVENTS
// -----------------------------------------------------------------------------

Event.on("applicationDidLaunch", (app) => {
  if (app.name === 'iTerm2') {
    _.each(app.windows({ visible: true }), (win) => {
      const r = win.screen.frameWithoutDockOrMenu;

      const x = r.x + MARGIN;
      const y = r.y + MARGIN;

      const width = r.width / 2 - (MARGIN + (MARGIN / 2));
      const height = r.height - (MARGIN * 2);

      win.setFrame({ x, y, width, height });
    });
  }
});

// -----------------------------------------------------------------------------
// APP POSITIONING
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
