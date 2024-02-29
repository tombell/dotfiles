// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

const ctrlShift = ["ctrl", "shift"];
const ctrlOpt = ["ctrl", "opt"];
const ctrlShiftOpt = ["ctrl", "shift", "opt"];

const margin = 12;

const gridColumns = 12;
const gridRoes = 10;

// -----------------------------------------------------------------------------
// WINDOW MANAGEMENT
// -----------------------------------------------------------------------------

const grid = (columns, rows, x, y, addMargin = true) => {
  const win = Window.focused();

  if (!win) {
    return;
  }

  const {
    width,
    height,
    x: offsetX,
    y: offsetY,
  } = win.screen.flippedVisibleFrame;

  const cellWidth = width / gridColumns;
  const cellHeight = height / gridRoes;

  const marginValue = addMargin ? margin : 0;

  win.setFrame({
    width: cellWidth * columns - marginValue * 2,
    height: cellHeight * rows - marginValue * 2,
    x: offsetX + marginValue + cellWidth * x,
    y: offsetY + marginValue + cellHeight * y,
  });
};

// Centre full
Keymap.on("c", ctrlShift, () => grid(12, 10, 0, 0));

// Centre medium
Keymap.on("x", ctrlShift, () => grid(10, 8, 1, 1, false));

// Centre medium, full height
Keymap.on("x", ctrlShiftOpt, () => grid(8, 10, 2, 0));

// Centre small
Keymap.on("z", ctrlShift, () => grid(8, 6, 2, 2, false));

// Centre small, full height
Keymap.on("z", ctrlShiftOpt, () => grid(6, 10, 3, 0));

// Left-half
Keymap.on("h", ctrlShift, () => grid(6, 10, 0, 0));

// Right-half
Keymap.on("l", ctrlShift, () => grid(6, 10, 6, 0));

// Left-one third
Keymap.on("h", ctrlOpt, () => grid(4, 10, 0, 0));

// Right-one third
Keymap.on("l", ctrlOpt, () => grid(4, 10, 8, 0));

// Left-two thirds
Keymap.on("h", ctrlShiftOpt, () => grid(8, 10, 0, 0));

// Right-two thirds
Keymap.on("l", ctrlShiftOpt, () => grid(8, 10, 4, 0));

// -----------------------------------------------------------------------------
// SPACES MANAGEMENT
// -----------------------------------------------------------------------------

[...Array(Space.all().length).keys()].forEach((i) => {
  const key = `${i + 1}`;

  Keymap.on(key, ctrlShift, () => {
    Space.at(i).moveWindows([Window.focused()].filter(Boolean));
  });

  Keymap.on(key, ctrlShiftOpt, () => {
    const win = Window.focused();
    Space.at(i).moveWindows([win].filter(Boolean));
    win.focus();
  });
});
