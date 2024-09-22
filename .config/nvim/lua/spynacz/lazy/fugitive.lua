return {
  {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
      vim.keymap.set("n", "<leader>gl", function() vim.cmd("Git log") end)
      vim.keymap.set("n", "gj", function() vim.cmd("diffget //2") end)
      vim.keymap.set("n", "gk", function() vim.cmd("diffget //3") end)
    end
  },
}
