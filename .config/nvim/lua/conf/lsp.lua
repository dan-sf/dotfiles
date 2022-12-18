
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    -- 'tsserver',
    -- 'eslint',
    'sumneko_lua',
    'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
    sign_icons = { }
    -- sign_icons = {
    --     error = 'E',
    --     warn = 'W',
    --     hint = 'H',
    --     info = 'I',
    -- }
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    completion = { autocomplete = false },
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          telemetry = {
              enable = false,
          },
      }
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()







--       M = {}
--       
--       -- TODO: these settings haven't been fully worked out, this needs some updating/tweaking
--       
--       -- require("mason").setup()
--       -- require("mason-lspconfig").setup({
--       --     ensure_installed = { "sumneko_lua", "pyright" }
--       -- })
--       
--       -- -- Mappings.
--       -- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
--       -- local opts = { noremap=true, silent=true }
--       -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
--       -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
--       -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
--       -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
--       
--       -- Use an on_attach function to only map the following keys
--       -- after the language server attaches to the current buffer
--       local on_attach = function(client, bufnr)
--           -- -- Enable completion triggered by <c-x><c-o>
--           -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--       
--           -- Mappings.
--           -- See `:help vim.lsp.*` for documentation on any of the below functions
--           local bufopts = { noremap=true, silent=true, buffer=bufnr }
--           vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--           vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--           vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--           -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--           -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--           -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--           -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--           -- vim.keymap.set('n', '<space>wl', function()
--           --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--           -- end, bufopts)
--           -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--           -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--           -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--           -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--           -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
--       end
--       
--       local function load()
--       
--           -- -- Add additional capabilities supported by nvim-cmp
--           -- local capabilities = vim.lsp.protocol.make_client_capabilities()
--           -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--           local capabilities = require('cmp_nvim_lsp').default_capabilities()
--       
--           require('lspconfig').pyright.setup({
--               on_attach = on_attach,
--               -- flags = lsp_flags,
--               autostart = false,
--               capabilities = capabilities,
--           })
--       
--           require('lspconfig').sumneko_lua.setup({
--               settings = {
--                   Lua = {
--                       runtime = {
--                           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                           version = 'LuaJIT',
--                       },
--                       diagnostics = {
--                           -- Get the language server to recognize the `vim` global
--                           globals = {'vim'},
--                       },
--                       workspace = {
--                           -- Make the server aware of Neovim runtime files
--                           library = vim.api.nvim_get_runtime_file("", true),
--                       },
--                       -- Do not send telemetry data containing a randomized but unique identifier
--                       telemetry = {
--                           enable = false,
--                       },
--                   },
--               },
--               on_attach = on_attach,
--               -- flags = lsp_flags,
--               autostart = false,
--               capabilities = capabilities,
--           })
--       
--           -- luasnip setup
--           local luasnip = require 'luasnip'
--       
--           -- nvim-cmp setup
--           local cmp = require 'cmp'
--           cmp.setup {
--               snippet = {
--                   expand = function(args)
--                       luasnip.lsp_expand(args.body)
--                   end,
--               },
--               mapping = cmp.mapping.preset.insert({
--                   ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--                   ['<C-f>'] = cmp.mapping.scroll_docs(4),
--                   ['<C-Space>'] = cmp.mapping.complete(),
--                   ['<CR>'] = cmp.mapping.confirm {
--                       behavior = cmp.ConfirmBehavior.Replace,
--                       select = true,
--                   },
--                   ['<Tab>'] = cmp.mapping(function(fallback)
--                       if cmp.visible() then
--                           cmp.select_next_item()
--                       elseif luasnip.expand_or_jumpable() then
--                           luasnip.expand_or_jump()
--                       else
--                           fallback()
--                       end
--                   end, { 'i', 's' }),
--                   ['<S-Tab>'] = cmp.mapping(function(fallback)
--                       if cmp.visible() then
--                           cmp.select_prev_item()
--                       elseif luasnip.jumpable(-1) then
--                           luasnip.jump(-1)
--                       else
--                           fallback()
--                       end
--                   end, { 'i', 's' }),
--               }),
--               sources = {
--                   { name = 'nvim_lsp' },
--                   { name = 'luasnip' },
--               },
--           }
--       end
--       M.load = load
--       
--       return M
