local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "numToStr/Comment.nvim",                  opts = {} },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        mode = { "n", "v" },
        { "g",         group = "+goto" },
        { "]",         group = "+next" },
        { "[",         group = "+prev" },
        { "gb",        group = "+buffer" },
        { "<leader>c", group = "+code" },
        { "<leader>d", group = "+debugger" },
        { "<leader>x", group = "+diagnostics/quickfix" },
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.indentscope",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-a>"] = actions.toggle_selection,
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      })
      telescope.load_extension("file_browser")
      telescope.load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    build = "make",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "catppuccin",
        global_status = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics" },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {},
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        telescope = true,
        mason = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "christoomey/vim-tmux-navigator",
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      icons = false,
    },
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    -- event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
    config = function()
    end,
  },
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        "j-hui/fidget.nvim",
        tag = "v1.4.0",
        opts = {
          progress = {
            display = {
              done_icon = "✓", -- Icon shown when all LSP progress tasks are complete
            },
          },
          notification = {
            window = {
              winblend = 0, -- Background color opacity in the notification window
            },
          },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = { justMyCode = false },
            -- Command line arguments for runner
            -- Can also be a function to return dynamic values
            args = { "--log-level", "DEBUG" },
            -- Runner to use. Will use pytest if available by default.
            -- Can be a function to return dynamic value.
            runner = "pytest",
            -- Custom python path for the runner.
            -- Can be a string or a list of strings.
            -- Can also be a function to return dynamic value.
            -- If not provided, the path will be inferred by checking for
            -- virtual envs in the local directory and for Pipenev/Poetry configs
            python = "./venv/bin/python",
            -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
            -- instances for files containing a parametrize mark (default: false)
            -- pytest_discover_instances = true,
          }),
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",

      -- Installs the debug adapters for you
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",

      -- Add your own debuggers here
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          -- 'delve',
          "debugpy",
        },
      })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup({
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- Install golang specific config
      -- require('dap-go').setup()
      require("dap-python").setup()
    end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' },
              },
            },
            opts = { skip = true },
          }
        },
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      --   "rcarriga/nvim-notify",
    }
  },
})

require("sergushka.options")
require("sergushka.keymaps")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})
