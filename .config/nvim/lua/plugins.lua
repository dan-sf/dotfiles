
-- Install packer if its not already on the system @TODO: We should probably init Mason and Treesitter as well if doing a clean install
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd("packadd packer.nvim")
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

        use {
            'nvim-lualine/lualine.nvim', -- Lua line
            config = function() require('conf.lualine') end,
        }

        -- Tab line markers, helpful for nested python code
        use {
            'lukas-reineke/indent-blankline.nvim',
            opt = true,
            setup = function()
                -- TODO: We might want to map this to a keyboard shortcut
                vim.api.nvim_create_user_command('ToggleIndentBlankline', 'lua require("conf.indent_blankline").toggle()', {})
            end,
            config = function()
                require("indent_blankline").setup {
                    -- for example, context is off by default, use this to turn it on
                    show_current_context = true,
                    show_current_context_start = true,
                }
            end,
        }

        -- Lsp setup
        use {
            'VonHeikemen/lsp-zero.nvim',
            opt = true,
            cmd = { 'LspInfo', 'LspLog', 'LspRestart', 'LspStart', 'LspStop', },
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-nvim-lua'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
            },
            -- This lazy loading does work unless I used the 'wants' feature,
            -- however, this feature is un-documented and might be short lived:
            -- https://github.com/wbthomason/packer.nvim/issues/537
            -- Should watch out because if this feature is removed in the
            -- future it'll break my conf
            -- Looks like once this issue is resolved, we should be okay just using requires: https://github.com/wbthomason/packer.nvim/issues/87
            wants = {
                'nvim-cmp',
                'nvim-lspconfig',
                'mason.nvim',
                'mason-lspconfig.nvim',
            },
            config = function()
                require("conf.lsp")
            end,
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
        use { "gruvbox-community/gruvbox", config = function() vim.cmd("colorscheme gruvbox") end, }
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
