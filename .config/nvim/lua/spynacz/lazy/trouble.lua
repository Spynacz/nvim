return {

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = "Trouble",

    opts = {
      modes = {
        diag_preview = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    },

    keys = {
      { "<leader>vv", "<cmd> Trouble toggle <cr>",                           desc = "Trouble toggle" },
      { "<leader>vd", "<cmd> Trouble diag_preview toggle <cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>vq", "<cmd> Trouble quickfix toggle <cr>",                  desc = "Quickfix (Trouble)" },
      { "<leader>vl", "<cmd> Trouble loclist toggle  <cr>",                  desc = "Loclist (Trouble)" },
      { "<leader>lu", "<cmd> Trouble lsp_references toggle focus=true <cr>", desc = "LSP References (Trouble)" },
      { "<leader>li", "<cmd> Trouble lsp_implementations toggle <cr>",       desc = "LSP Implementations (Trouble)" },
    },

    -- config = function()
    --   -- vim.keymap.set("n", "<leader>vv", "<cmd> Trouble toggle <cr>")
    --   -- vim.keymap.set("n", "<leader>vd", "<cmd> Trouble diag_preview toggle <cr>")
    --   -- vim.keymap.set("n", "<leader>vq", "<cmd> Trouble quickfix toggle <cr>")
    --   -- vim.keymap.set("n", "<leader>vl", "<cmd> Trouble loclist toggle <cr>")
    --   -- vim.keymap.set("n", "<leader>lu", "<cmd> Trouble lsp_references toggle focus=true <cr>")
    --   -- vim.keymap.set("n", "<leader>li", "<cmd> Trouble lsp_implementations toggle <cr>")
    --
    -- end
  },
}
