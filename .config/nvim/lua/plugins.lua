
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
        use "tpope/vim-fugitive" -- Plugin for git

        -- For some reason this doesn't work...
        --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Treesitter
        use { 'nvim-treesitter/nvim-treesitter' } -- Treesitter

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = { "nvim-telescope/telescope-fzf-native.nvim", "nvim-lua/plenary.nvim" }
        }

        -- Get colorschemes
        use "folke/tokyonight.nvim"
        use "arcticicestudio/nord-vim"
        use "gruvbox-community/gruvbox"
        use "sainnhe/everforest"
        use "ajmwagar/vim-deus"
        use "dikiaap/minimalist"
        use "danilo-augusto/vim-afterglow"
        use "lifepillar/vim-wwdc16-theme"
        use "cocopon/iceberg.vim"
        use "sainnhe/sonokai" -- this might be better than gruvbox...

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

    -- -- Telescope
    -- Plug 'nvim-telescope/telescope.nvim'
    -- Plug 'nvim-lua/plenary.nvim'
    -- Plug 'nvim-telescope/telescope-fzf-native.nvim'
    -- Plug 'nvim-treesitter/nvim-treesitter'

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
