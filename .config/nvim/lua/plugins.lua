
-- Install packer if its not already on the system
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("ERROR: Unable to load Packer")
    return
end

-- TODO: we can enable this after getting things solidified
-- -- Re-sync packer whenever this file is updated
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

return packer.startup({
    function(use)
        use 'wbthomason/packer.nvim' -- Let packer manage itself

        -- Plugin for git
        use {
            "tpope/vim-fugitive",
            opt = true,
            cmd = { "Git", },
        }

        -- Impatient for faster startup
        use {
            'lewis6991/impatient.nvim',
            config = function() require('impatient') end,
        }

        -- For some reason this doesn't work...
        --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function() require('conf.treesitter') end,
        } -- Treesitter

        use {
            "nvim-tree/nvim-tree.lua", -- File explorer
            opt = true,
            cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen", },
            setup = function() require('conf.nvim-tree').pre_load() end,
            config = function() require('conf.nvim-tree').load() end,
        }


        use 'nvim-lualine/lualine.nvim' -- Lua line

        -- use 'hrsh7th/nvim-cmp'
        -- -- Plug 'neovim/nvim-lspconfig'
        -- -- Plug 'hrsh7th/cmp-nvim-lsp'
        -- -- Plug 'hrsh7th/cmp-buffer'
        -- -- Plug 'hrsh7th/cmp-path'
        -- -- Plug 'hrsh7th/cmp-cmdline'

        -- lsp -- TODO: Can we make this optional? We only need to load this stuff when turning the lsp on...
        use {
            "williamboman/mason.nvim",
            opt=true,
            cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
            config = function() require("mason").setup() end,
            requires = {
                "williamboman/mason-lspconfig.nvim",
                opt=true,
                config = function()
                    require("mason-lspconfig").setup({
                        ensure_installed = { "sumneko_lua", "pyright" }
                    })
                end,
            },
        }

        use {
            -- { "williamboman/mason.nvim", opt=true, },
            -- { "williamboman/mason-lspconfig.nvim", opt=true, },
            -- { "neovim/nvim-lspconfig", opt=true, },
            -- { "hrsh7th/nvim-cmp", opt=true, }, -- Autocompletion
            -- { "hrsh7th/cmp-nvim-lsp", opt=true, }, -- LSP source for nvim-cmp
            -- { "saadparwaiz1/cmp_luasnip", opt=true, }, -- Snippets source for nvim-cmp
            -- { "L3MON4D3/LuaSnip", opt=true, }, -- Snippets plugin

            -- { "williamboman/mason.nvim", opt=true, },
            -- { "williamboman/mason-lspconfig.nvim", opt=true, },
            -- { "neovim/nvim-lspconfig", opt=true, config = function() require('conf.lsp') end, cmd = { 'LspStart' }},
            -- { "hrsh7th/nvim-cmp", opt=true, }, -- Autocompletion
            -- { "hrsh7th/cmp-nvim-lsp", opt=true, }, -- LSP source for nvim-cmp
            -- { "saadparwaiz1/cmp_luasnip", opt=true, }, -- Snippets source for nvim-cmp
            -- { "L3MON4D3/LuaSnip", opt=true, }, -- Snippets plugin

            -- "williamboman/mason.nvim",
            -- "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp", -- Autocompletion
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
            "L3MON4D3/LuaSnip", -- Snippets plugin
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            opt = true,
            cmd = {'Telescope'},
            setup = function() require('conf.telescope').pre_load() end,
            config = function() require('conf.telescope').load() end,
            requires = {
                "nvim-telescope/telescope-fzf-native.nvim",
                { "nvim-lua/plenary.nvim", module = "plenary" }
            },
        }

        -- Only load the colorscheme I'm currently using
        use { "gruvbox-community/gruvbox", config = function() vim.cmd([[colorscheme gruvbox]]) end, }
        -- -- Get colorschemes
        -- use "folke/tokyonight.nvim"
        -- use "arcticicestudio/nord-vim"
        -- use "sainnhe/everforest"
        -- use "ajmwagar/vim-deus"
        -- use "dikiaap/minimalist"
        -- use "danilo-augusto/vim-afterglow"
        -- use "lifepillar/vim-wwdc16-theme"
        -- use "cocopon/iceberg.vim"
        -- use "sainnhe/sonokai" -- this might be better than gruvbox...

    -- TODO: These are the plugins from the previous init.vim, I don't think we need these but keeping here for now
    -- Plug 'tpope/vim-fugitive' -- Plugin for git
    -- Plug 'scrooloose/nerdtree' -- NerdTree

    -- -- Powerline for vim
    -- Plug 'vim-airline/vim-airline-themes'
    -- Plug 'vim-airline/vim-airline'
    -- let g:airline_theme='papercolor'

    -- -- FZF fuzzy finder plugins
    -- Plug 'junegunn/fzf'
    -- Plug 'junegunn/fzf.vim'

    -- -- Language specific
    -- Plug 'sophacles/vim-processing', { 'for': 'processing' } -- Add processing functionality
    -- Plug 'dan-sf/hive.vim', { 'for': 'hive' } -- Add hive syntax
    -- Plug 'derekwyatt/vim-scala', { 'for': 'scala' } -- Add scala syntax
    -- Plug 'zig-lang/zig.vim', { 'for': 'zig' } -- Add zig syntax
    -- Plug 'b4b4r07/vim-hcl', { 'for': 'hcl' } -- Add hcl syntax
    -- Plug 'rust-lang/rust.vim', { 'for': 'rust' } -- Add rust syntax
    -- Plug 'racer-rust/vim-racer', { 'for': 'rust' } -- Rust code completion
    -- Plug 'Tetralux/odin.vim', { 'for': 'odin' } -- Add odin syntax

    -- -- Ctags handling
    -- Plug 'ludovicchabant/vim-gutentags'

        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})



-- local fn = vim.fn
-- 
-- -- Automatically install packer
-- local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
-- if fn.empty(fn.glob(install_path)) > 0 then
--   PACKER_BOOTSTRAP = fn.system {
--     "git",
--     "clone",
--     "--depth",
--     "1",
--     "https://github.com/wbthomason/packer.nvim",
--     install_path,
--   }
--   print "Installing packer close and reopen Neovim..."
--   vim.cmd [[packadd packer.nvim]]
-- end
-- 
-- -- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]
-- 
-- -- Use a protected call so we don't error out on first use
-- local status_ok, packer = pcall(require, "packer")
-- if not status_ok then
--   return
-- end
-- 
-- -- Have packer use a popup window
-- packer.init {
--   display = {
--     open_fn = function()
--       return require("packer.util").float { border = "rounded" }
--     end,
--   },
-- }
-- 
-- -- Install your plugins here
-- return packer.startup(function(use)
--   -- My plugins here
--   use "wbthomason/packer.nvim" -- Have packer manage itself
--   use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
--   use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
-- 
--   -- Automatically set up your configuration after cloning packer.nvim
--   -- Put this at the end after all plugins
--   if PACKER_BOOTSTRAP then
--     require("packer").sync()
--   end
-- end)
-- 
