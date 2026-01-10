local opt = vim.opt

opt.hlsearch = false
opt.wrap = true
opt.breakindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.clipboard = "unnamedplus"

-- Spellcheck
opt.spelllang = "en"
opt.spellsuggest = "best,9"
opt.spell = true

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- Spellcheck
opt.spelllang = "en"
opt.spellsuggest = "best,9"
opt.spell = true

-- Bootstrapping Lazy
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

--Lazy config
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    require("telescope"),       -- From telescope.lua
    require("treesitter"),      -- From treesitter.lua
    require("mason"),           -- From mason.lua

    -- Mason LSPconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {}
        end,
    },

    -- Nvim LSPconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            -- Add your LSP configurations here
        end,
    },

    -- Rust Tools
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup({})
        end,
    },

    -- Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup {}
        end,
    },
})

-- Define the custom command `:IDE`
vim.api.nvim_create_user_command(
  'IDE',
  function()
    vim.cmd('Neotree')   -- Open Neo-tree
    vim.cmd('wincmd p')  -- Switch back to the previous window
  end,
  {}
)

