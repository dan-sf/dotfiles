
local actions = require("telescope.actions")
local util = require("util")

require('telescope').setup{
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                -- Note: I don't think these will work...
                -- ["<C-Down>"] = actions.preview_scrolling_down,
                -- ["<C-Up>"] = actions.preview_scrolling_up,

                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"

            },
            n = {
                ["d"] = "delete_buffer",
                --["q"] = actions.send_to_qflist + actions.open_qflist,
                ["q"] = actions.send_selected_to_qflist + actions.open_qflist,
            }
        }
    },
    pickers = {
        find_files = {
            -- Exclude venv dirs
            find_command = { "fd", "--type", "f", "--color", "never", "--exclude", "venv" }
        }
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --     picker_config_key = value,
        --     ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --     extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

-- Telescope keymaps
util.nnoremap("<leader>f", "<cmd>Telescope find_files<cr>")
util.nnoremap("<leader>g", "<cmd>Telescope live_grep<cr>")
util.nnoremap("<leader>b", "<cmd>Telescope buffers<cr>")
-- util.nnoremap("<leader>h", "<cmd>Telescope help_tags<cr>")

