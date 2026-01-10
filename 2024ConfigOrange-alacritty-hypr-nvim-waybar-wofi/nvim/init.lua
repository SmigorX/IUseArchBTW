local opt = vim.opt

-- Basics --
opt.hlsearch = false
opt.wrap = true
opt.breakindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.clipboard = "unnamedplus"

-- Spellcheck --
opt.spelllang = "en"
opt.spellsuggest = "best,9"
opt.spell = true

-- Numbers --
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#eb551f' })
vim.api.nvim_set_hl(0, 'LineNr', { fg='white' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#eb551f' })

-- Bootstrapping Lazy --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

opt.rtp:prepend(lazypath)

vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

--Lazy config --
require("lazy").setup({
    require("copilot"),
    require("lsp"),           
    require("telescope"),
    require("treesitter"),
    require("tree"),
    require("vimtex"),
})

-- Custom mappings --
vim.api.nvim_create_user_command(
  'IDE',
  function()
    vim.cmd('Neotree')   -- Open Neo-tree
    vim.cmd('wincmd p')  -- Switch back to the previous window
    vim.cmd('split')     -- Horizontal split
    vim.cmd('wincmd w')    
    vim.cmd('terminal')  -- Opens terminal in the new window   
    vim.cmd('resize 10') -- Shrinks terminal window
    vim.cmd('wincmd p')  -- Moves focus back to main window    
  end,
  {}
)

vim.api.nvim_set_keymap('n', 'U', ':redo<CR>', { noremap = true, silent = true })


