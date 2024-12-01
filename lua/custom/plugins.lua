local plugins = {
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      require "custom.configs.formatter"
    end
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function ()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function ()
      opts = require("plugins.configs.treesitter")
      opts.ensure_installed = {
        "lua",
        "typescript",
        "javascript",
        "css",
        "tsx",
        "go",
        "rust",
      }
      return opts
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "typescript-language-server",
        "tailwindcss-language-server",
        "black",
        "debugpy",
        "mypy",
        "pyright",
        "gopls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "mlaursen/vim-react-snippets",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      require("vim-react-snippets").lazy_load()
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,

      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, 
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
      merge_keywords = true,
      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    }    
  },
}
return plugins














-- local plugins = {
--   {
--     "mhartington/formatter.nvim",
--     event = "VeryLazy",
--     opts = function()
--       require "custom.configs.formatter"
--     end
--   },
--   {
--     "nvim-neotest/nvim-nio",
--   },
--   {
--     "rcarriga/nvim-dap-ui",
--     dependencies = "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--       local dapui = require("dapui")
--       dapui.setup()
--       dap.listeners.after.event_initialized["dapui_config"] = function()
--         dapui.open()
--       end
--       dap.listeners.before.event_terminated["dapui_config"] = function()
--         dapui.close()
--       end
--       dap.listeners.before.event_exited["dapui_config"] = function()
--         dapui.close()
--       end
--     end
--   },
--   {
--     "mfussenegger/nvim-dap",
--     config = function(_, opts)
--       require("core.utils").load_mappings("dap")
--     end
--   },
--   {
--     "mfussenegger/nvim-dap-python",
--     ft = "python",
--     dependencies = {
--       "mfussenegger/nvim-dap",
--       "rcarriga/nvim-dap-ui",
--       "nvim-neotest/nvim-nio",
--     },
--     config = function(_, opts)
--       local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
--       require("dap-python").setup(path)
--       require("core.utils").load_mappings("dap_python")
--     end,
--   },
--   {
--     "nvimtools/none-ls.nvim",
--     ft = {"python"},
--     opts = function()
--       return require "custom.configs.null-ls"
--     end,
--   },
--   {
--     "windwp/nvim-ts-autotag",
--     ft = {
--       "javascript",
--       "javascriptreact",
--       "typescript",
--       "typescriptreact",
--     },
--     config = function ()
--       require("nvim-ts-autotag").setup()
--     end
--   },
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function ()
--       opts = require("plugins.configs.treesitter")
--       opts.ensure_installed = {
--         "lua",
--         "typescript",
--         "javascript",
--         "css",
--         "tsx",
--         "go",
--         "rust",
--       }
--       return opts
--     end
--   },
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ensure_installed = {
--         "eslint-lsp",
--         "prettierd",
--         "typescript-language-server",
--         "tailwindcss-language-server",
--         "black",
--         "debugpy",
--         "mypy",
--         "pyright",
--         "gopls",
--       },
--     },
--   },
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       require "plugins.configs.lspconfig"
--       require "custom.configs.lspconfig"
--     end,
--   },
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       "L3MON4D3/LuaSnip",
--       "saadparwaiz1/cmp_luasnip",
--       "mlaursen/vim-react-snippets",
--     },
--     opts = function()
--       vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
--       require("vim-react-snippets").lazy_load()
--     end,
--   },
--   -- todo comment
--   {
--     "folke/todo-comments.nvim",
--     lazy = false,
--     dependencies = { "nvim-lua/plenary.nvim" },
--     opts = {
--       -- your configuration comes here
--       -- or leave it empty to use the default settings
--       -- refer to the configuration section below
--     }
--   },
-- }
-- return plugins
