local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>o', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})

require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            }
        }
    }
})

require('telescope').load_extension('fzf')
