// -----------------------------------------------------------------------------
// CONSTANTS
// -----------------------------------------------------------------------------

const ctrlShift = ["ctrl", "shift"];
const ctrlOpt = ["ctrl", "opt"];
const ctrlShiftOpt = ["ctrl", "shift", "opt"];

const margin = 12;

// -----------------------------------------------------------------------------
// WINDOW MANAGEMENT
// -----------------------------------------------------------------------------

const grid = (
  totalCols,
  totalRows,
  columns,
  rows,
  x,
  y,
  addMargin = true,
  adjustMargin = false,
) => {
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

  const cellWidth = width / totalCols;
  const cellHeight = height / totalRows;

  const marginValue = addMargin ? margin : 0;

  const frame = {
    width: cellWidth * columns - marginValue * 2,
    height: cellHeight * rows - marginValue * 2,
    x: offsetX + marginValue + cellWidth * x,
    y: offsetY + marginValue + cellHeight * y,
  };

  if (adjustMargin) {
    frame.width += margin / 2;
    frame.x -= x === 0 ? 0 : margin / 2;
  }

  win.setFrame(frame);
};

// Centre full
Keymap.on("c", ctrlShift, () => grid(12, 10, 12, 10, 0, 0));

// Centre medium
Keymap.on("x", ctrlShift, () => grid(12, 10, 10, 8, 1, 1, false));

// Centre medium, full height
Keymap.on("x", ctrlShiftOpt, () => grid(12, 10, 8, 10, 2, 0));

// Centre small
Keymap.on("z", ctrlShift, () => grid(12, 10, 8, 6, 2, 2, false));

// Centre small, full height
Keymap.on("z", ctrlShiftOpt, () => grid(12, 10, 6, 10, 3, 0));

// Left-half
Keymap.on("h", ctrlShift, () => grid(12, 10, 6, 10, 0, 0, true, true));

// Right-half
Keymap.on("l", ctrlShift, () => grid(12, 10, 6, 10, 6, 0, true, true));

// Left-one third
Keymap.on("h", ctrlOpt, () => grid(12, 10, 4, 10, 0, 0, true, true));

// Right-one third
Keymap.on("l", ctrlOpt, () => grid(12, 10, 4, 10, 8, 0, true, true));

// Left-two thirds
Keymap.on("h", ctrlShiftOpt, () => grid(12, 10, 8, 10, 0, 0, true, true));

// Right-two thirds
Keymap.on("l", ctrlShiftOpt, () => grid(12, 10, 8, 10, 4, 0, true, true));

// Move window to previous display
Keymap.on("left", ctrlShift, () => {
  const win = Window.focused();

  if (win && win.screen.id !== win.screen.previous.id) {
    const { x, y } = win.frame;
    const frame = win.screen.previous.flippedVisibleFrame;
    const diff = frame.height - win.screen.flippedVisibleFrame.height;

    win.setFrame({
      width: win.frame.width,
      height: win.frame.height - diff,
      x: x - frame.width,
      y: y - frame.height + diff,
    });
  }
});

// Move window to next display
Keymap.on("right", ctrlShift, () => {
  const win = Window.focused();

  if (win && win.screen.id !== win.screen.next.id) {
    const { x, y } = win.frame;
    const frame = win.screen.next.flippedVisibleFrame;
    const diff = win.screen.flippedVisibleFrame.height - frame.height;

    win.setFrame({
      width: win.frame.width,
      height: win.frame.height + diff,
      x: x + frame.x,
      y: y + frame.y - diff,
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
