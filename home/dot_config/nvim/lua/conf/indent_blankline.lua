local M = {}

M.toggle = function()
    if vim.g.indent_blankline_enabled == nil then
        require('packer').loader('indent-blankline.nvim')
    else
        if vim.g.indent_blankline_enabled then
            vim.g.indent_blankline_enabled = false
        else
            vim.g.indent_blankline_enabled = true
        end
    end
end

return M
