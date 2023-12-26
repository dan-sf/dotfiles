-- Various options settings, see ':help options' for more info on these

-- Set the default colorscheme (we re-set this in colorscheme.lua after plugins are loaded)
vim.cmd("colorscheme desert") -- TODO how can this be done with lua?
vim.opt.fileformats = "unix,mac,dos" -- Set default file formats

-- Make vim run faster by turning off swap files/backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.mouse = "a" -- Allow for mouse use
vim.opt.mousemodel = "extend" -- Don't go into visual block mode when cmd-clicking
vim.opt.number = true -- Set line numbers to visible
vim.opt.numberwidth = 4 -- Set default line number width

-- This fails for some reason
-- vim.opt.statusline = "%M\ %F\ %=[%{&ff},%{&ft}]\ [(%l,%v)/%L\ %p%%]" -- Set what is displayed on the status line
vim.cmd [[ "%M\ %F\ %=[%{&ff},%{&ft}]\ [(%l,%v)/%L\ %p%%]" ]] -- Set what is displayed on the status line
vim.opt.hlsearch = false
vim.opt.splitbelow = true -- Default :sp to split below
vim.opt.splitright = true -- Default :vsp to split right
vim.opt.whichwrap = "<,>,[,],b,s" -- Use cursors, space, and backspace to wrap

-- Use case insensitive search, except when using capital letters (smartcase)
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.confirm = true -- Ask to save file if quitting with unsaved files open

-- NOTE: not sure if we need these...
-- vim.opt.lazyredraw = true -- Don't redraw while executing macros (good performance config)
-- vim.opt.more = true -- Finish more output right away

vim.opt.helpheight = 10 -- Set help file height (default 20)
vim.opt.timeoutlen = 500 -- Wait less on multiple key commands

-- Set up tab execution (python style)
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Try to make sure vim updates files that have been externally edited (this also relies on tmux focus events being set: 'set-option -g focus-events on')
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
-- TODO: Maybe we should also auto save when we leave vim -> au FocusLost,WinLeave * :silent! noautocmd w

vim.opt.foldenable = false

-- Enable cursorline highlight for the number side only
vim.opt.cursorlineopt = "number"
vim.opt.cursorline = true

vim.cmd [[autocmd BufEnter * if &filetype == "text" | setlocal ft=conf | endif]] -- Syntax highlight text files like they are conf files
vim.cmd [[autocmd BufEnter * setlocal formatoptions-=cro]] -- Stop vim from creating automatic comments, see :help fo-table for specifics
vim.cmd [[autocmd BufEnter *.md setlocal textwidth=80]] -- Auto text wrap for md files
vim.cmd [[autocmd FileType java setlocal ts=4 sts=4 sw=4]] -- Space indent for java

-- Set filetype to bash for custom rc files
vim.cmd [[autocmd BufEnter .workrc setlocal ft=bash]]
vim.cmd [[autocmd BufEnter .homerc setlocal ft=bash]]

vim.opt.smartindent = true

-- New options settings, maybe we want these, maybe not
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)

-- Disable builtin vim plugins @Note: We might want to re-enable if needed
local default_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    -- "syntax",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

vim.g.loaded = 1
for _, plugin in pairs(default_plugins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Disable remote plugin providers since we don't use them
local default_providers = {
    "node",
    "perl",
    "python3",
    "ruby",
}

for _, provider in ipairs(default_providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

