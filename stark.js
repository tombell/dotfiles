// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

// Default modifier keys for binds
const MODIFIERS = ['ctrl', 'shift'];

// Grid width and height for centering windows with different sizes
const GRID_WIDTH = 12;
const GRID_HEIGHT = 10;

// Margin to have around each window edge
const MARGIN = 10;

// App names
const apps = {
  iterm: 'iTerm2',
  macvim: 'MacVim',
  tweetbot: 'Tweetbot',
};

// -----------------------------------------------------------------------------
// FUNCTIONS
// -----------------------------------------------------------------------------

Bind.on('s', MODIFIERS, () => {
  Stark.run('/usr/local/bin/lock', []);
});

// -----------------------------------------------------------------------------
// DEBUG & PLAYGROUND
// -----------------------------------------------------------------------------

Bind.on('d', MODIFIERS, () => {});

// -----------------------------------------------------------------------------
// SPOTIFY CONTROLLING
// -----------------------------------------------------------------------------

Bind.on('q', MODIFIERS, () => {
  Stark.run('/usr/bin/osascript', [
    '-e', `tell application "Spotify"`,
    '-e',`  set player position to 0`,
    '-e',`  previous track`,
    '-e', `end tell`,
  ]);
});

Bind.on('w', MODIFIERS, () => {
  Stark.run('/usr/bin/osascript', ['-e', `tell application "Spotify" to playpause`]);
});

Bind.on('e', MODIFIERS, () => {
  Stark.run('/usr/bin/osascript', ['-e', `tell application "Spotify" to next track`]);
});

// -----------------------------------------------------------------------------
// WINDOW CENTERING
// -----------------------------------------------------------------------------

Bind.on('z', MODIFIERS, () => {
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

Bind.on('x', MODIFIERS, () => {
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

Bind.on('c', MODIFIERS, () => {
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

Bind.on('g', MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const r = win.screen.frameWithoutDockOrMenu;

  const { y, width, height } = win.frame;

  const x = (r.width / 2) - (width / 2);

  win.setTopLeft({ x, y });
});

// -----------------------------------------------------------------------------
// WINDOW POSITIONING
// -----------------------------------------------------------------------------

Bind.on('h', MODIFIERS, () => {
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

Bind.on('l', MODIFIERS, () => {
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

Bind.on('j', MODIFIERS, () => {
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

Bind.on('k', MODIFIERS, () => {
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
// SPACES MANAGEMENT
// -----------------------------------------------------------------------------

function moveWindowToSpace(win, space) {
  const current = Space.active();
  current.removeWindows([win]);
  space.addWindows([win]);
}

function moveWindowToSpaceAndFocus(win, space) {
  moveWindowToSpace(win, space);
  win.focus();
}

Bind.on('1', MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const [one] = Space.all();
  moveWindowToSpace(win, one);
});

Bind.on('2', MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const [one, two] = Space.all();
  moveWindowToSpace(win, two);
});

Bind.on('3', MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const [one, two, three] = Space.all();
  moveWindowToSpace(win, three);
});

Bind.on('4', MODIFIERS, () => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const [one, two, three, four] = Space.all();
  moveWindowToSpace(win, four);
});

// -----------------------------------------------------------------------------
// APP POSITIONING
// -----------------------------------------------------------------------------

Bind.on('t', MODIFIERS, () => {
  const app = App.find(apps.tweetbot);

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
// EVENTS
// -----------------------------------------------------------------------------

Event.on('applicationDidLaunch', (app) => {
  if (app.name === apps.iterm && !app.isTerminated) {
    _.each(app.windows({ visible: true }), (win) => {
      const r = win.screen.frameWithoutDockOrMenu;

      const x = r.x + MARGIN;
      const y = r.y + MARGIN;

      const width = r.width / 2 - (MARGIN + (MARGIN / 2));
      const height = r.height - (MARGIN * 2);

      win.setFrame({ x, y, width, height });
    });

    return;
  }
});
