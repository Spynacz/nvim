vim.keymap.set("n", "<leader>vv", "<cmd> Trouble toggle <cr>")
vim.keymap.set("n", "<leader>vd", "<cmd> Trouble diag_preview toggle <cr>")
vim.keymap.set("n", "<leader>vq", "<cmd> Trouble quickfix toggle <cr>")
vim.keymap.set("n", "<leader>vl", "<cmd> Trouble loclist toggle <cr>")
vim.keymap.set("n", "<leader>lu", "<cmd> Trouble lsp_references toggle focus=true <cr>")
vim.keymap.set("n", "<leader>li", "<cmd> Trouble lsp_implementations toggle <cr>")

require("trouble.config").setup({
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
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd([[cclose]])
        vim.cmd([[Trouble qflist open]])
      end)
    end
  end,
})
