
-- -- Don't show INSERT/VISUAL/... in the command line. This is displayed by the lualine
-- vim.opt.showmode = false

return {
    options = {
        icons_enabled = false,
        theme = 'gruvbox',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {}, -- { { 'branch', icon = '•' } }, 'diff', 'diagnostics'},
        lualine_c = { { 'filename', path = 1 } },
        -- lualine_x = {'encoding', {'fileformat', symbols = { unix = 'Unix', mac = 'Mac', dos = 'Dos' }}, 'filetype'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

