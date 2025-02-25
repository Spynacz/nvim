return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },

  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'Jezda1337/nvim-html-css' },
      { 'mlaursen/vim-react-snippets' },
      { 'micangl/cmp-vimtex' },
    },

    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local cmp_action = require('lsp-zero').cmp_action()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('vim-react-snippets').lazy_load()

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
                -- "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css",
              }
            }
          },
        },
        { name = 'vim-react-snippets' },
        { name = 'vimtex' },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
          })
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-l>'] = cmp_action.luasnip_jump_forward(),
          ['<C-h>'] = cmp_action.luasnip_jump_backward(),
          -- ['<Tab>'] = cmp_action.luasnip_supertab(),
          -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        }),
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'nvimtools/none-ls.nvim' },
      { 'pmizio/typescript-tools.nvim' },
    },

    config = function()
      local lsp_zero = require('lsp-zero')

      local lsp_attach = function(client, bufnr)
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
      end

      lsp_zero.extend_lspconfig({
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

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
          'ts_ls',
        },
        handlers = {
          lsp_zero.default_setup,

          jdtls = lsp_zero.noop,

          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,

          eslint = function()
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
          end,

          cssls = function()
            require('lspconfig').cssls.setup({
              init_options = {
                provideFormatter = false,
              }
            })
          end,

          texlab = function()
            vim.keymap.set("n", "<leader>lv", "<cmd> TexlabForward <cr>")
            require('lspconfig').texlab.setup({
              settings = {
                texlab = {
                  build = {
                    onSave = true
                  },
                  forwardSearch = {
                    executable = "zathura",
                    args = { "--synctex-forward", "%l:1:%f", "%p" }
                  },
                  formatterLineLength = 120,
                  latexindent = {
                    modifyLineBreaks = true
                  }
                }
              }
            })
          end
        },
      })

      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
      })

      require("typescript-tools").setup({
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "<leader>i",
            function()
              vim.cmd("TSToolsAddMissingImports sync")
              vim.cmd("TSToolsOrganizeImports sync")
            end, opts)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
          complete_function_calls = true,
          include_completions_with_insert_text = true,
        },
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
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  {
    'onsails/lspkind.nvim',
    lazy = true
  },
}
