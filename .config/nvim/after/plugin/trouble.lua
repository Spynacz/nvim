vim.keymap.set("n", "<leader>vv", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>vw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>vd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>vq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>vl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gr", function() require("trouble").open("lsp_references") end)
