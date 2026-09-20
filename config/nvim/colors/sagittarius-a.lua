-- Sagittarius A: warm accretion-disc colours against a near-black sky.
vim.opt.background = "dark"
vim.cmd "highlight clear"
if vim.g.syntax_on then
  vim.cmd "syntax reset"
end
vim.g.colors_name = "sagittarius-a"

local c = {
  bg = "#11101C",
  selection = "#302536",
  fg = "#F4D9C4",
  muted = "#C5A5AD",
  comment = "#9B8294",
  peach = "#F2B49D",
  cream = "#FFF1C2",
  gold = "#F5D49D",
  rose = "#D59AAA",
  red = "#E39494",
  orange = "#ECA080",
  blue = "#8DBDE0",
}

local highlights = {
  -- Editor and menus.
  Normal = { fg = c.fg, bg = c.bg },
  NormalNC = { link = "Normal" },
  NormalFloat = { fg = c.fg, bg = c.bg },
  FloatBorder = { fg = c.comment, bg = c.bg },
  FloatTitle = { fg = c.peach, bold = true },
  EndOfBuffer = { fg = c.bg },
  NonText = { fg = c.comment },
  Whitespace = { fg = c.selection },
  SpecialKey = { fg = c.comment },
  Conceal = { fg = c.comment },
  Cursor = { fg = c.bg, bg = c.peach },
  CursorLine = { bg = c.selection },
  CursorColumn = { link = "CursorLine" },
  ColorColumn = { link = "CursorLine" },
  LineNr = { fg = c.comment },
  CursorLineNr = { fg = c.peach, bold = true },
  SignColumn = { bg = c.bg },
  FoldColumn = { fg = c.comment, bg = c.bg },
  Folded = { fg = c.blue, bg = c.selection },
  WinSeparator = { fg = c.selection },
  StatusLine = { fg = c.fg, bg = c.selection },
  StatusLineNC = { fg = c.comment, bg = c.bg },
  TabLine = { fg = c.muted, bg = c.bg },
  TabLineFill = { bg = c.bg },
  TabLineSel = { fg = c.peach, bg = c.selection, bold = true },
  WinBar = { fg = c.fg, bg = c.bg },
  WinBarNC = { fg = c.comment, bg = c.bg },
  Pmenu = { fg = c.fg, bg = c.bg },
  PmenuSel = { fg = c.cream, bg = c.selection, bold = true },
  PmenuSbar = { bg = c.selection },
  PmenuThumb = { bg = c.comment },
  Visual = { bg = c.selection },
  Search = { fg = c.bg, bg = c.gold },
  IncSearch = { fg = c.bg, bg = c.peach },
  CurSearch = { link = "IncSearch" },
  MatchParen = { fg = c.cream, bg = c.selection, bold = true },
  Directory = { fg = c.blue },
  Title = { fg = c.peach, bold = true },
  Question = { fg = c.blue },
  MoreMsg = { fg = c.blue },
  ModeMsg = { fg = c.peach, bold = true },
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.gold },

  -- Traditional syntax groups also provide Tree-sitter and LSP fallbacks.
  Comment = { fg = c.comment, italic = true },
  Constant = { fg = c.orange },
  String = { fg = c.gold },
  Character = { link = "String" },
  Number = { fg = c.orange },
  Boolean = { link = "Number" },
  Float = { link = "Number" },
  Identifier = { fg = c.fg },
  Function = { fg = c.peach },
  Statement = { fg = c.rose },
  Operator = { fg = c.muted },
  Keyword = { fg = c.rose },
  PreProc = { fg = c.blue },
  Type = { fg = c.blue },
  Special = { fg = c.cream },
  Delimiter = { fg = c.muted },
  Underlined = { fg = c.blue, underline = true },
  Ignore = { fg = c.comment },
  Error = { fg = c.red, undercurl = true, sp = c.red },
  Todo = { fg = c.cream, bg = c.selection, bold = true },

  -- Tree-sitter captures that benefit from explicit colours.
  ["@variable"] = { fg = c.fg },
  ["@variable.builtin"] = { fg = c.rose },
  ["@variable.parameter"] = { fg = c.muted },
  ["@variable.member"] = { fg = c.fg },
  ["@property"] = { fg = c.fg },
  ["@punctuation.bracket"] = { link = "Delimiter" },
  ["@punctuation.delimiter"] = { link = "Delimiter" },
  ["@punctuation.special"] = { link = "Special" },
  ["@markup.heading"] = { link = "Title" },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.link.url"] = { link = "Underlined" },
  ["@markup.raw"] = { link = "String" },

  -- Diagnostics and spelling.
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.gold },
  DiagnosticInfo = { fg = c.blue },
  DiagnosticHint = { fg = c.rose },
  DiagnosticOk = { fg = c.blue },
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c.gold },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue },
  DiagnosticUnderlineHint = { undercurl = true, sp = c.rose },
  DiagnosticDeprecated = { fg = c.comment, strikethrough = true },
  DiagnosticUnnecessary = { fg = c.comment },
  SpellBad = { undercurl = true, sp = c.red },
  SpellCap = { undercurl = true, sp = c.gold },
  SpellLocal = { undercurl = true, sp = c.blue },
  SpellRare = { undercurl = true, sp = c.rose },
  LspReferenceText = { bg = c.selection },
  LspReferenceRead = { link = "LspReferenceText" },
  LspReferenceWrite = { link = "LspReferenceText" },
  LspInlayHint = { fg = c.comment },

  -- Diffs and the plugins used by this configuration.
  DiffAdd = { fg = c.blue, bg = c.selection },
  DiffChange = { bg = c.selection },
  DiffDelete = { fg = c.red, bg = c.selection },
  DiffText = { fg = c.bg, bg = c.gold, bold = true },
  Added = { fg = c.blue },
  Changed = { fg = c.gold },
  Removed = { fg = c.red },
  GitSignsAdd = { link = "Added" },
  GitSignsChange = { link = "Changed" },
  GitSignsDelete = { link = "Removed" },
  SnacksIndent = { fg = c.selection },
  SnacksIndentScope = { fg = c.blue },
}

for group, highlight in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, highlight)
end

-- ANSI slots keep terminal buffers within the same palette.
local terminal = {
  c.bg, c.red, c.blue, c.gold, c.blue, c.rose, c.peach, c.fg,
  c.comment, c.red, c.blue, c.cream, c.blue, c.rose, c.peach, c.cream,
}
for index, colour in ipairs(terminal) do
  vim.g["terminal_color_" .. (index - 1)] = colour
end
