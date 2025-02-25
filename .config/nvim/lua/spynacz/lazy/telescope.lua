return {
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
      -- { 'nvim-telescope/telescope-media-files.nvim' }, doesn't work in kitty
    },

    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>o', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})

      require('telescope').setup({
        defaults = {
          path_display = { filename_first = true },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            }
          }
        }
      })

      require('telescope').load_extension('fzf')
    end
  },

  {
    'nvim-telescope/telescope-file-browser.nvim',
    lazy = true,
    event = "VeryLazy",

    config = function()
      require('telescope').load_extension 'file_browser'

      vim.api.nvim_set_keymap(
        "n",
        "<space>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { noremap = true }
      )
    end
  },

  -- {
  --   'nvim-telescope/telescope-media-files.nvim',
  --   lazy = true,
  --   event = "VeryLazy",
  --
  --   config = function()
  --     require('telescope').load_extension('media_files')
  --   end
  -- }
}
