return {
  {
    'folke/which-key.nvim',
    lazy = true,
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},

    config = function()
      local wk = require("which-key")

      wk.add({
        { "<leader><space>",  group = "Swap split" },
        { "<leader><space>h", desc = "Swap split left" },
        { "<leader><space>j", desc = "Swap split down" },
        { "<leader><space>k", desc = "Swap split up" },
        { "<leader><space>l", desc = "Swap split right" },
        { "<leader>Y",        desc = "Yank line to system clipboard" },
        { "<leader>a",        desc = "Harpoon add file" },
        { "<leader>f",        group = "File search" },
        { "<leader>fb",       desc = "File browser" },
        { "<leader>fg",       desc = "Git files" },
        { "<leader>fl",       desc = "Live grep" },
        { "<leader>fs",       desc = "Grep search" },
        { "<leader>g",        group = "Git" },
        { "<leader>gl",       desc = "Git log" },
        { "<leader>gs",       desc = "Git status" },
        { "<leader>h",        desc = "Signature help" },
        { "<leader>l",        group = "LSP actions" },
        { "<leader>lc",       desc = "Code action" },
        { "<leader>ld",       desc = "Show diagnostics" },
        { "<leader>lf",       desc = "Format file" },
        { "<leader>lr",       desc = "Rename" },
        { "<leader>lw",       desc = "List workspace symbols" },
        { "<leader>o",        desc = "Find files" },
        { "<leader>p",        group = "File explorer" },
        { "<leader>pv",       desc = "File explorer" },
        { "<leader>s",        desc = "Replace word under cursor" },
        { "<leader>u",        desc = "Show undotree" },
        -- { "<leader>v",        group = "Trouble" },
        -- { "<leader>vq",       desc = "Trouble quickfix" },
        -- { "<leader>vv",       desc = "Trouble" },
        { "gD",               desc = "Go to declaration" },
        { "gd",               desc = "Go to definition" },
        { "<leader>p",        desc = "Paste over and keep clipboard",      mode = "x" },
        { "<leader>d",        desc = "Delete to void register",            mode = { "n", "v" } },
        { "<leader>y",        desc = "Yank selection to system clipboard", mode = { "n", "v" } },
      })
    end
  },
}
