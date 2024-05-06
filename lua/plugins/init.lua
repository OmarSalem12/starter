return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
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
    -- config = function(_, opts)
      -- require("core.utils").load_mappings("dap")
    -- end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      -- require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- ft = {"python", "r", "rmd", "bash"},
    lazy = false,
    opts = function()
      return require "configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      -- require "configs.lspconfig"
    end,
  },
  {
    "jpalardy/vim-slime",
    lazy = false,
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = ".1" }
      vim.g.slime_paste_file = vim.fn.expand("$HOME/.slime_paste")
      vim.g.indentline_leadingSpaceEnabled = 1
      vim.g.indentline_leadingSpaceChar = ".>"
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_python_ipython = 1
      vim.api.nvim_set_keymap('x', '<Space>', '<Plug>SlimeRegionSend<ESC>\'>j', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<Space>', '<Plug>SlimeLineSend<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('x', '<C-c><C-c>', '<Plug>SlimeRegionSendgv\'<ESC>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<C-c><C-c>', '<Plug>SlimeParagraphSendgv\'<ESC>', {noremap = true, silent = true})
      --vim.api.nvim_set_keymap('i', '<Tab>', '<C-y>', {noremap = true, silent = true})
      --vim.api.nvim_set_keymap('i', '<Down>', '<C-n>', {noremap = true, silent = true})
      --vim.api.nvim_set_keymap('i', '<Up>', '<C-p>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('i', '<expr> <Up>', 'pumvisible() ? "<C-p>" : "<Up>"', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('i', '<expr> <Down>', 'pumvisible() ? "<C-n>" : "<Down>"', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('i', '<expr> <Tab>', 'pumvisible() ? "<C-y>" : "<Tab>"', {noremap = true, silent = true})



    end
  },
  {
    "github/copilot.vim",
    lazy = false,
    -- ft = {"python", "r", "rmd"},
    config = function ()
      vim.cmd[[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
      -- vim.cmd[[let g:copilot_no_tab_map = v:true]]
      vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(copilot-next)', {silent = true})
      vim.api.nvim_set_keymap('i', '<C-h>', '<Plug>(copilot-previous)', {silent = true})
      vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(copilot-suggest)', {silent = true})
    end
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      local auto_session = require("auto-session")

      auto_session.setup({
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      })

      local keymap = vim.keymap

      keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
      keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
    end,
  },
  {
      "stevearc/dressing.nvim",
      event = "VeryLazy",
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
      { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
    },
  },
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo_comments = require("todo-comments")

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "]t", function()
        todo_comments.jump_next()
      end, { desc = "Next todo comment" })

      keymap.set("n", "[t", function()
        todo_comments.jump_prev()
      end, { desc = "Previous todo comment" })

      todo_comments.setup()
    end,

  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.noice")
    end,
    opts = {
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  },
  {
    "nvim-neotest/nvim-nio"
  },
    -- Add nvim oil 
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true
      })
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    -- put any other flags you wanted to pass to lazy here!
    config = function()
        require("neorg").setup({
            -- ... -- put any of your previous config here
        })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.api.nvim_set_keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left" })
      vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down" })
      vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up" })
      vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right" })
      vim.api.nvim_set_keymap("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Navigate previous" })
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   config = function ()
  --     local configs = require("nvim-treesitter.configs")
  --
  --     configs.setup({
  --         ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python", "r" },
  --         sync_install = false,
  --         highlight = { enable = true },
  --         indent = { enable = true },
  --       })
  --   end
  -- },
}


  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
