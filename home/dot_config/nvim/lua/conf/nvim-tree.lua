local M = {}

local util = require("util")

-- -- Disable netrw, recommended by nvim-tree plugin
-- vim.g.loaded = 1
-- vim.g.loaded_netrwPlugin = 1

local function load()
    -- Didn't want to install 'nvim-web-devicons' so this setup mostly just removes those default settings
    require("nvim-tree").setup({
        renderer = {
            icons = {
                glyphs = {
                    default = "",
                    symlink = "",
                    bookmark = "",
                    folder = {
                        default = "",
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        -- -- @Note: we might just want to set these all to "", I just did that for the defaults with non-existant glyphs
                        -- unstaged = "✗",
                        -- staged = "✓",
                        -- unmerged = "",
                        -- renamed = "➜",
                        -- untracked = "★",
                        -- deleted = "",
                        -- ignored = "◌",

                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "",
                        untracked = "",
                        deleted = "",
                        ignored = "",
                    },
                }
            }
        },
        view = {
            mappings = {
                list = {
                    -- { key = "l", action = "edit" },
                    -- { key = "h", action = "close_node" },
                    -- { key = "h", action = "close_node" },
                    { key = "<C-[>", action = "dir_up" },
                },
            },
        },
    })
end
M.load = load

--   view.mappings.list = { -- BEGIN_DEFAULT_MAPPINGS
--     { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
--     { key = "<C-e>",                          action = "edit_in_place" },
--     { key = "O",                              action = "edit_no_picker" },
--     { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
--     { key = "<C-v>",                          action = "vsplit" },
--     { key = "<C-x>",                          action = "split" },
--     { key = "<C-t>",                          action = "tabnew" },
--     { key = "<",                              action = "prev_sibling" },
--     { key = ">",                              action = "next_sibling" },
--     { key = "P",                              action = "parent_node" },
--     { key = "<BS>",                           action = "close_node" },
--     { key = "<Tab>",                          action = "preview" },
--     { key = "K",                              action = "first_sibling" },
--     { key = "J",                              action = "last_sibling" },
--     { key = "I",                              action = "toggle_git_ignored" },
--     { key = "H",                              action = "toggle_dotfiles" },
--     { key = "U",                              action = "toggle_custom" },
--     { key = "R",                              action = "refresh" },
--     { key = "a",                              action = "create" },
--     { key = "d",                              action = "remove" },
--     { key = "D",                              action = "trash" },
--     { key = "r",                              action = "rename" },
--     { key = "<C-r>",                          action = "full_rename" },
--     { key = "x",                              action = "cut" },
--     { key = "c",                              action = "copy" },
--     { key = "p",                              action = "paste" },
--     { key = "y",                              action = "copy_name" },
--     { key = "Y",                              action = "copy_path" },
--     { key = "gy",                             action = "copy_absolute_path" },
--     { key = "[e",                             action = "prev_diag_item" },
--     { key = "[c",                             action = "prev_git_item" },
--     { key = "]e",                             action = "next_diag_item" },
--     { key = "]c",                             action = "next_git_item" },
--     { key = "-",                              action = "dir_up" },
--     { key = "s",                              action = "system_open" },
--     { key = "f",                              action = "live_filter" },
--     { key = "F",                              action = "clear_live_filter" },
--     { key = "q",                              action = "close" },
--     { key = "W",                              action = "collapse_all" },
--     { key = "E",                              action = "expand_all" },
--     { key = "S",                              action = "search_node" },
--     { key = ".",                              action = "run_file_command" },
--     { key = "<C-k>",                          action = "toggle_file_info" },
--     { key = "g?",                             action = "toggle_help" },
--     { key = "m",                              action = "toggle_mark" },
--     { key = "bmv",                            action = "bulk_move" },
--   } -- END_DEFAULT_MAPPINGS

local function pre_load()
    -- Nvim tree keymaps
    util.nnoremap("<leader>e", "<cmd>NvimTreeToggle<cr>")
end
M.pre_load = pre_load

return M
