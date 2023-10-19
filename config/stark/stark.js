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

  const { width, height, y: baseY } = win.screen.flippedVisibleFrame;
  const cellWidth = width / gridColumns;
  const cellHeight = height / gridRoes;

  const marginValue = addMargin ? margin : 0;

  win.setFrame({
    width: cellWidth * columns - marginValue * 2,
    height: cellHeight * rows - marginValue * 2,
    x: marginValue + cellWidth * x,
    y: marginValue + baseY + cellHeight * y,
  });
};

// Centre full
Bind.on("c", ctrlShift, () => grid(12, 10, 0, 0));

// Centre medium
Bind.on("x", ctrlShift, () => grid(10, 8, 1, 1, false));

// Centre small
Bind.on("z", ctrlShift, () => grid(8, 6, 2, 2, false));

// Left-half
Bind.on("h", ctrlShift, () => grid(6, 10, 0, 0));

// Right-half
Bind.on("l", ctrlShift, () => grid(6, 10, 6, 0));

// Left-one third
Bind.on("h", ctrlOpt, () => grid(4, 10, 0, 0));

// Right-one third
Bind.on("l", ctrlOpt, () => grid(4, 10, 8, 0));

// Left-two thirds
Bind.on("h", ctrlShiftOpt, () => grid(8, 10, 0, 0));

// Right-two thirds
Bind.on("l", ctrlShiftOpt, () => grid(8, 10, 4, 0));

// -----------------------------------------------------------------------------
// SPACES MANAGEMENT
// -----------------------------------------------------------------------------

[...Array(Space.all().length).keys()].forEach((i) => {
  const key = `${i + 1}`;

  Bind.on(key, ctrlShift, () => {
    Space.at(i).moveWindows([Window.focused()].filter(Boolean));
  });

  Bind.on(key, ctrlShiftOpt, () => {
    const win = Window.focused();
    Space.at(i).moveWindows([win].filter(Boolean));
    win.focus();
  });
});
