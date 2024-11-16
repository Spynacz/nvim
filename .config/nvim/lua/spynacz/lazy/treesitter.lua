return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = "VeryLazy",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

    opts = {
      -- require('nvim-treesitter.configs').setup {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "java", "javascript", "typescript", "tsx" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,
        -- list of language that will be disabled
        disable = {},
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<C-s>',
          node_decremental = '<C-S-space>',
        }
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,       -- Auto close tags
          enable_rename = true,      -- Auto rename pairs of tags
          enable_close_on_slash = true -- Auto close on trailing </
        }
      })
    end
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {}
  },
}
