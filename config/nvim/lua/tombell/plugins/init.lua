local nmap = require("tombell.keymap").nmap

local lazy = require "lazy"

lazy.setup {
  "wbthomason/packer.nvim",

  "stevearc/dressing.nvim",

  {
    "lukas-reineke/virt-column.nvim",
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_current_context = true,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      no_italic = true,
      highlight_overrides = {
        mocha = function(mocha)
          return {
            Folded = { fg = mocha.blue, bg = mocha.mantle },
            VertSplit = { fg = mocha.surface0, bg = mocha.base },
          }
        end,
      },
    },
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  {
    "anuvyklack/pretty-fold.nvim",
    opts = {
      sections = {
        left = { "content", "" },
        right = { "(", "number_of_folded_lines", ")" },
      },
      fill_char = " ",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    init = function()
      local builtin = require "telescope.builtin"
      nmap { "<C-p>", builtin.find_files }
      nmap { "<C-g>", builtin.live_grep }
      nmap { "<Leader>f", builtin.grep_string }
    end,
    opts = function()
      local actions = require "telescope.actions"
      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--glob", "!.git/*" },
            hidden = true,
            previewer = false,
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    "rafaelsq/nvim-goc.lua",
    opts = {},
    init = function()
      local goc = require "nvim-goc"
      nmap { "<Leader>gcr", goc.Coverage }
      nmap { "<Leader>gcc", goc.ClearCoverage }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      ensure_installed = {
        "bash",
        "css",
        "go",
        "gomod",
        "html",
        "javascript",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "scss",
        "swift",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "tombell.plugins.lsp.servers"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "tombell.plugins.lsp.cmp"
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "tombell.plugins.lsp.null-ls"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
