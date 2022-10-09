
M = {}

-- Shortcut functions/vars
local keymap = vim.api.nvim_set_keymap
M.keymap = keymap

-- Modes for mapping keys:
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local function nmap(lhs, rhs, opts)
    opts = opts or {}
    keymap("n", lhs, rhs, opts)
end
M.nmap = nmap

local function imap(lhs, rhs, opts)
    opts = opts or {}
    keymap("i", lhs, rhs, opts)
end
M.imap = imap

local function vmap(lhs, rhs, opts)
    opts = opts or {}
    keymap("v", lhs, rhs, opts)
end
M.vmap = vmap

local function nnoremap(lhs, rhs, opts)
    opts = opts or { noremap = true }
    keymap("n", lhs, rhs, opts)
end
M.nnoremap = nnoremap

return M

