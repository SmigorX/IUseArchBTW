return {
    {          
        "williamboman/mason.nvim",
        config = function()
        require("mason").setup()  
        end
    },
  
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },

    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup()
        end,
    },

    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    },

    {
        "nvim-lua/lsp-status.nvim", -- Add lsp-status to display status
        config = function()
            require("lsp-status").register_progress()
        end,
    },

    {
        "neovim/nvim-lspconfig", -- Add lspconfig for Rust Analyzer setup
        config = function()
            local lspconfig = require("lspconfig")
        end,
    },
}    
