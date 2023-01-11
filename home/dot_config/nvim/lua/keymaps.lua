
-- Shortcut functions/vars
local util = require("util")
local keymap = util.keymap
local nmap = util.nmap
local imap = util.imap
local vmap = util.vmap
local nnoremap = util.nnoremap

-- Treat long lines as break lines (useful when moving around in them)
nmap("j", "gj")
nmap("k", "gk")

-- Move a line of text using CTRL+[JK]
nmap("<c-J>", ":m +1<CR>", {silent = true})
nmap("<c-K>", ":m -2<CR>", {silent = true})
vmap("<c-J>", ":m '>+1<CR><CR>gv", {silent = true})
vmap("<c-K>", ":m '<-2<CR>gv", {silent = true})

-- Use Ctrl-n to toggle line numbers
nmap("<c-n>", ":set invnumber<CR>")
imap("<c-n>", "<Esc>:set invnumber<CR>a")




-- @TODO: Evaluate these keymappings
-- -- Keep cursor in the middle of the screen when using crtl-d|u
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- -- Keep the cursor in the middle of the screen when searching
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
-- -- Paste over the selected without losing what you pasted from the clipboard (x is visual mode, see :help map-modes)
-- vim.keymap.set("x", "<leader>p", [["_dP]])
-- -- Yank to the system clipboard
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
-- -- Delete without putting the deleted value into the clipboard
-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])





-- TODO: I don't think I want to use nerdtree anymore...
-- -- Use Ctrl-x to toggle nerd tree
-- nmap("<c-x>", ":NERDTreeToggle<CR>")

-- -- NOTE: these options are now obsolete according to the options help page
-- -- Use F12 (func F12 on mac) to toggle paste mode
-- nmap("<F12>", ":set invpaste<CR>")
-- imap("<F12>", "<Esc>:set invpaste<CR>a")
-- set pastetoggle=<F12> -- TODO

-- Use control keys to get around in tabs
nmap("<c-l>", "gt")
nmap("<c-h>", "gT")

-- Use space as the leader key
nnoremap("<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use leader and movement keys to move around windows
nmap("<leader>j", "<C-W><C-J>")
nmap("<leader>k", "<C-W><C-K>")
nmap("<leader>l", "<C-W><C-L>")
nmap("<leader>h", "<C-W><C-H>")

-- Yank an entire file
nmap("<leader>c", ":%y<CR>")

-- Yank highlighted text into the clipboard
vmap("<leader>y", [["*y]])

-- Prevent nvim from mapping Y to y$ (see default-mappings)
vim.cmd([[unmap Y]])

-- Open current file in IntelliJ
vim.cmd([[command Idea :!open -na "IntelliJ IDEA CE.app" --args "%"]])

-- TODO: these were not ported over from the previous init.vim, I feel like we don't need these but keeping here until we are sure
--     " Command for bash tab mapping
--     command Bashtabs :set tabstop=4 | set shiftwidth=4 | set noexpandtab
-- 
--     " Command for bash tab mapping
--     command Pythontabs :set tabstop=8 | set expandtab | set shiftwidth=4 | set softtabstop=4
-- 
--     " Mappings for fzf
--     nmap <C-p> :Files<CR>
--     nmap <leader>a :Rg<CR>
--     nmap <leader>b :Buffers<CR>
-- 
--     nmap <leader>n :bn<CR>
--     nmap <leader>p :bp<CR>
-- 
--     " Commands for having a buffer delete window
--     " https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
--     nmap <leader>d :BuffersDelete<CR>
--     function! s:list_buffers()
--       redir => list
--       silent ls
--       redir END
--       return split(list, "\n")
--     endfunction
-- 
--     function! s:delete_buffers(lines)
--       execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
--     endfunction
-- 
--     command! BuffersDelete call fzf#run(fzf#wrap({
--       \ 'source': s:list_buffers(),
--       \ 'sink*': { lines -> s:delete_buffers(lines) },
--       \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
--     \ }))
-- 
--     " Only search file contents when using Rg (fzf)
--     command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, <bang>0)
-- 
--     " Stop weird indenting when using comments in yaml files
--     autocmd FileType yaml setlocal indentkeys-=0#


-- TODO
-- Create some insert mode mappings that are emacs-like, similar to how it works on in the terminal, this will help when in insert mode and needed to make some movements



-- TODO: these are various ideas from other people's nvim confs, we should look through these to see if we want to copy anything
-- local opts = { noremap = true, silent = true }
-- 
-- local term_opts = { silent = true }
-- 
-- -- Shorten function name
-- local keymap = vim.api.nvim_set_keymap
-- 
-- --Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
-- 
-- -- Modes
-- --   normal_mode = "n",
-- --   insert_mode = "i",
-- --   visual_mode = "v",
-- --   visual_block_mode = "x",
-- --   term_mode = "t",
-- --   command_mode = "c",
-- 
-- -- Normal --
-- -- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)
-- 
-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)
-- 
-- -- Resize with arrows
-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- 
-- -- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- 
-- -- Insert --
-- -- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)
-- 
-- -- Visual --
-- -- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)
-- 
-- -- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)
-- 
-- -- Visual Block --
-- -- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- 
-- -- Terminal --
-- -- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- 
