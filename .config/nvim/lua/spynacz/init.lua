require("spynacz.remap")
require("spynacz.set")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
    },

    { 'nvim-telescope/telescope-file-browser.nvim' },

    { 'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    { 'norcalli/nvim-colorizer.lua' },

    { 'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },

    { 'tpope/vim-fugitive' },

    { 'ThePrimeagen/harpoon' },

    { 'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Custom
            {'mfussenegger/nvim-jdtls'},
            {'nvimtools/none-ls.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/cmp-nvim-lua'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},

            {'L3MON4D3/LuaSnip'},      -- Required
            {'rafamadriz/friendly-snippets'},
        }
    },

    { 'nvim-tree/nvim-web-devicons' },

    { 'rose-pine/neovim',
        name = 'rose-pine',
    },

    { 'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000
    },

    { 'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })()
        end,
        dependencies = {
            {'windwp/nvim-ts-autotag'}
        }
    },

    { 'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },

    { 'mbbill/undotree' },

    { 'folke/which-key.nvim',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },

    -- { 'roobert/hoversplit.nvim' },

    { 'mrjones2014/smart-splits.nvim',
        build = './kitty/install-kittens.bash' },

    { 'folke/zen-mode.nvim' },

    { 'onsails/lspkind.nvim' },

    { 'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap',
            'ChristianChiarulli/neovim-codicons' } },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
require("spynacz.theme")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("highlight_yank", {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup="IncSearch",
            timeout = 50,
        })
    end,
})

--augroup highlight_yank
--au TextYankPost * silent! lua vim.highlight.on_yank()
--augroup END
