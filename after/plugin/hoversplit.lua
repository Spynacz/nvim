require("hoversplit").setup({
    key_bindings = {
        split = "<leader>hs",
        vsplit = "<leader>hv",
    }
})

local hover = require('hoversplit')

vim.keymap.set("n", "<leader>hs", function() hover.split_remain_focused() end)
vim.keymap.set("n", "<leader>hv", function() hover.vsplit_remain_focused() end)
vim.keymap.set("n", "<leader>hS", function() hover.split() end)
vim.keymap.set("n", "<leader>hV", function() hover.vsplit() end)