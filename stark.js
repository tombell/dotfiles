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

const sound1 = Bind.on("1", MODIFIERS, function() {
  Stark.run("/usr/local/bin/soundsource", ["-o", "Internal Speakers"])
});

const sound2 = Bind.on("2", MODIFIERS, function() {
  Stark.run("/usr/local/bin/soundsource", ["-o", "Creative T15 Wireless"])
});

const sound3 = Bind.on("3", MODIFIERS, function() {
  Stark.run("/usr/local/bin/soundsource", ["-o", "Headphones"])
});

// -----------------------------------------------------------------------------

const screensaver = Bind.on("s", MODIFIERS, function() {
  Stark.run("/usr/bin/open", ["/System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app"]);
});

// -----------------------------------------------------------------------------

const small = Bind.on("z", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const x = (r.width / GRID_WIDTH) * 2;
  const y = r.y + (r.height / GRID_HEIGHT) * 2;

  const width = (r.width / GRID_WIDTH) * 8;
  const height = (r.height / GRID_HEIGHT) * 6;

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const medium = Bind.on("x", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const x = r.width / GRID_WIDTH;
  const y = r.y + (r.height / GRID_HEIGHT);

  const width = (r.width / GRID_WIDTH) * 10;
  const height = (r.height / GRID_HEIGHT) * 8;

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const large = Bind.on("c", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const x = r.x + MARGIN;
  const y = r.y + MARGIN;

  const width = r.width - (MARGIN * 2);
  const height = r.height - (MARGIN * 2);

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const center = Bind.on("f", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const width = r.width / 2;
  const height = r.height - (MARGIN * 2);

  const x = r.x + (width / 2);
  const y = r.y + MARGIN;

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const left = Bind.on("h", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const x = r.x + MARGIN;
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height - (MARGIN * 2);

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const right = Bind.on("l", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const x = (r.x + (r.width / 2)) + (MARGIN / 2);
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height - (MARGIN * 2);

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const topLeft = Bind.on("j", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const x = r.x + MARGIN;
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height / 2 - (MARGIN + (MARGIN / 2));

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const topRight = Bind.on("k", MODIFIERS, function() {
  const win = Window.focusedWindow();
  if (!win) {
    return;
  }

  const r = win.screen().frameWithoutDockOrMenu;

  const x = (r.x + (r.width / 2)) + (MARGIN / 2);
  const y = r.y + MARGIN;

  const width = r.width / 2 - (MARGIN + (MARGIN / 2));
  const height = r.height / 2 - (MARGIN + (MARGIN / 2));

  win.setFrame({ x, y, width, height });
});

// -----------------------------------------------------------------------------

const twitter = Bind.on("t", MODIFIERS, function() {
  const app = App.find("Tweetbot");
  if (!app) {
    return;
  }

  _.each(app.allWindows(), function(win) {
    const r = win.screen().frameWithoutDockOrMenu;

    const x = r.x + MARGIN;
    const y = r.y + MARGIN;

    const width = r.width / 4 - (MARGIN + (MARGIN / 2));
    const height = r.height - (MARGIN * 2);

    win.setFrame({ x, y, width, height });
  });
});

// -----------------------------------------------------------------------------
