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
  spec = "spynacz.lazy",
  change_detection = { notify = false }
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
      higroup = "IncSearch",
      timeout = 50,
    })
  end,
})

--augroup highlight_yank
--au TextYankPost * silent! lua vim.highlight.on_yank()
--augroup END

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
