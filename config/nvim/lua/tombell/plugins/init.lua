local lazy = require "lazy"

lazy.setup {
  "wbthomason/packer.nvim",

  "stevearc/dressing.nvim",

  {
    "lukas-reineke/virt-column.nvim",
    opts = {},
  },

  {
    "m4xshen/smartcolumn.nvim",
    opts = { colorcolumn = 81 },
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
    keys = {
      { "<c-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
      { "<c-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
      { "<leader>f", "<cmd>lua require('telescope.builtin').grep_string()<cr>" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "echasnovski/mini.comment",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    "rafaelsq/nvim-goc.lua",
    opts = {},
    keys = {
      { "<leader>gcr", '<cmd>lua require("nvim-goc").Coverage()<cr>' },
      { "<leader>gcc", '<cmd>lua require("nvim-goc").ClearCoverage()<cr>' },
    },
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
