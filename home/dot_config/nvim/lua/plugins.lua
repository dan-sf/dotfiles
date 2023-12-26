
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


lazy_opts = {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}

lazy_plugins = {
  {
    "tpope/vim-fugitive",
    init = function()
      local util = require("util")
      util.nnoremap("<leader>gg", "<cmd>0G<cr>")
    end,
  },

  'tpope/vim-sleuth',

  -- Basically replaces "tpope/vim-vinegar" but with the ability to edit the
  -- file views like a buffer which will make updates to the file system
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = require('conf.treesitter'),
    config = function(_, opts)
      vim.opt.runtimepath:append("$HOME/.local/share/treesitter")
      require("nvim-treesitter.configs").setup(opts)
    end,
    -- tag = "v0.8.5.2",
  },

  {
    'nvim-lualine/lualine.nvim',
    init = function()
      -- Don't show INSERT/VISUAL/... in the command line. This is
      -- displayed by the lualine
      vim.opt.showmode = false
    end,
    opts = require('conf.lualine'),
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    init = function() vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = true,
    cmd = 'IndentBlanklineEnable',
    opts = {
      -- for example, context is off by default, use this to turn it on
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  -- LSP Config

  {
    'williamboman/mason.nvim',
    config = function() require("mason").setup() end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
      }
    end,
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    config = function()
      vim.opt.signcolumn = 'no'
      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {}
      -- TODO: Configure other the rest of your lsps
    end,

    -- TODO: Evaluate if you want to add neodev/fidget plugins
    -- dependencies = {
    --   -- Automatically install LSPs to stdpath for neovim
    --   'williamboman/mason.nvim',
    --   'williamboman/mason-lspconfig.nvim',

    --   -- -- Useful status updates for LSP
    --   -- -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    --   -- { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

    --   -- -- Additional lua configuration, makes nvim stuff amazing!
    --   -- 'folke/neodev.nvim',
    -- },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },




        -- TODO
        -- use {
        --     'neovim/nvim-lspconfig',
        --     opt = true,
        --     cmd = { 'LspInfo', 'LspLog', 'LspRestart', 'LspStart', 'LspStop', },
        --     requires = {
        --         -- LSP Support
        --         -- {'neovim/nvim-lspconfig'},
        --         {'williamboman/mason.nvim'},
        --         {'williamboman/mason-lspconfig.nvim'},

        --         -- Autocompletion
        --         {'hrsh7th/nvim-cmp'},
        --         {'hrsh7th/cmp-buffer'},
        --         {'hrsh7th/cmp-path'},
        --         {'saadparwaiz1/cmp_luasnip'},
        --         {'hrsh7th/cmp-nvim-lsp'},
        --         {'hrsh7th/cmp-nvim-lua'},

        --         -- Snippets
        --         {'L3MON4D3/LuaSnip'},
        --         {'rafamadriz/friendly-snippets'},
        --     },
        --     -- This lazy loading does not work unless I used the 'wants' feature,
        --     -- however, this feature is un-documented and might be short lived:
        --     -- https://github.com/wbthomason/packer.nvim/issues/537
        --     -- Should watch out because if this feature is removed in the
        --     -- future it'll most likely break my conf
        --     -- Looks like once this issue is resolved, we should be okay just using requires: https://github.com/wbthomason/packer.nvim/issues/87
        --     wants = {
        --         'nvim-cmp',
        --         -- 'nvim-lspconfig',
        --         'mason.nvim',
        --         'mason-lspconfig.nvim',
        --     },
        --     config = function()
        --         require("conf.lsp")
        --     end,
        -- },

  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = 'Telescope',
    init = function()
      local util = require("util")
      -- Telescope keymaps
      util.nnoremap("<leader>f", "<cmd>Telescope find_files<cr>")
      -- util.nnoremap("<leader>g", "<cmd>Telescope live_grep<cr>")
      util.nnoremap("<leader>tg", "<cmd>Telescope live_grep<cr>")
      util.nnoremap("<leader>tr", "<cmd>Telescope resume<cr>")
      util.nnoremap("<leader>ts", "<cmd>Telescope grep_string<cr>")
      util.nnoremap("<leader>tm", "<cmd>Telescope man_pages<cr>")
      util.nnoremap("<leader>tj", "<cmd>Telescope jumplist<cr>")
      util.nnoremap("<leader>b", "<cmd>Telescope buffers<cr>")
      util.nnoremap("<leader>th", "<cmd>Telescope help_tags<cr>")
    end,
    opts = function() require "telescope".setup(require('conf.telescope')) end,
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- { "nvim-lua/plenary.nvim", module = "plenary" }
      -- TODO: Not sure if the above is needed...
      "nvim-lua/plenary.nvim"
    },
  },

  -- Similar plugins to flash:
  -- https://github.com/ggandor/leap.nvim
  -- https://github.com/smoka7/hop.nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        -- Disable flash for f/F/t/T/;/, motions
        char = { enabled = false },
        -- Disable flash for running search via '/'
        search = { enabled = false },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- Not sure about these...
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      -- TODO: Create a 'ToggleFlash' command that you can run to turn flash on/off
    },
  },

  -- Only load the colorscheme I'm currently using
  {
    "gruvbox-community/gruvbox",
    config = function()
      -- Only highlight the number for the cursor line
      vim.g.gruvbox_cursorline = "bg0"
      vim.cmd("colorscheme gruvbox")
    end,
  },

    -- -- Get colorschemes
    -- "folke/tokyonight.nvim", -- the 'moon' or 'night' variants are good
    -- "arcticicestudio/nord-vim",
    -- "sainnhe/everforest",
    -- "ajmwagar/vim-deus",
    -- "dikiaap/minimalist",
    -- "danilo-augusto/vim-afterglow",
    -- "lifepillar/vim-wwdc16-theme",
    -- "cocopon/iceberg.vim",
    -- {
    --     "sainnhe/sonokai",
    --     config = function()
    --         -- Only highlight the number for the cursor line
    --         --vim.g.gruvbox_cursorline = "bg0"
    --         vim.g.sonokai_style = "maia"
    --         vim.cmd("colorscheme sonokai")
    --     end,
    -- },
}

require("lazy").setup(lazy_plugins, lazy_opts)

