local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>lw", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.document_symbol() end, opts)
    vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
end)

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
})

require('lspconfig').tsserver.setup({
    on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>i",
            function() vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } }) end,
            opts)
    end,

    format = { enable = false }
})

lsp_zero.setup()

require('mason').setup({
    ui = {
        keymaps = {
            apply_language_filter = "F",
        }
    }
})
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'lua_ls',
        'jdtls',
    },
    handlers = {
        lsp_zero.default_setup,
        jdtls = lsp_zero.noop,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')

require('luasnip.loaders.from_vscode').lazy_load()


cmp.setup({
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
        {
            name = 'html-css',
            option = {
                max_count = {},
                enable_on = { 'html', 'javascript', 'typescriptreact', 'ejs' },
                file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
                style_sheets = {
                    -- example of remote styles, only css no js for now
                    "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css",
                }
            }
        },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
        })
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-l>'] = cmp_action.luasnip_jump_forward(),
        ['<C-h>'] = cmp_action.luasnip_jump_backward(),
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    }),
})
require('html-css'):setup()

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format.with({
            disabled_filetypes = { 'java' },
        }),
        null_ls.builtins.formatting.djlint,
        null_ls.builtins.formatting.prettierd,
    },
})

require('lspconfig').eslint.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
    enable = true,
    format = { enable = false },
    packageManager = "npm",
})
