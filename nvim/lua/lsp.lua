return {
    { "hrsh7th/nvim-cmp" }, -- Completion plugin

    -- LSP source for nvim-cmp
    { "hrsh7th/cmp-nvim-lsp" },

    -- Add other necessary plugins for nvim-cmp
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },  -- Optional: Snippet support
    { "L3MON4D3/LuaSnip" },  -- Optional: Snippet engine

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

    {
        "nvim-lua/lsp-status.nvim",
        config = function()
            require("lsp-status").register_progress()
        end,
    },

    {
        "neovim/nvim-lspconfig", 
        config = function()
            local lspconfig = require("lspconfig")
            local cmp = require("cmp")

            -- Setup nvim-cmp for autocompletion
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- Optional: luasnip integration
                    end,
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion manually
                    --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
                    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                -- Disable automatic selection
                preselect = cmp.PreselectMode.None,
            })

            -- LSP configuration
            lspconfig.gopls.setup {
                on_attach = function(client, bufnr)
                    -- Keymaps for LSP actions
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                end,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            }
        end,
    },
}
