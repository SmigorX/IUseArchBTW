return {
    -- LSP completion source
    { "hrsh7th/cmp-nvim-lsp" },

    -- Python virtual environment selector
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            "mfussenegger/nvim-dap-python", -- optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = false,
        branch = "regexp",
        config = function()
            require("venv-selector").setup()

            -- Auto-open VenvSelect for Python if no venv is active
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "python",
                callback = function()
                    local venv = os.getenv("VIRTUAL_ENV")
                    if not venv or venv == "" then
                        vim.schedule(function()
                            vim.cmd("VenvSelect")
                        end)
                    end
                end,
            })

            -- Restart LSP when venv changes
            vim.api.nvim_create_autocmd("User", {
                pattern = "VenvSelectActivated",
                callback = function()
                    vim.cmd("LspRestart pylsp")
                    vim.notify("Python LSP restarted with new venv 🐍", vim.log.levels.INFO)
                end,
            })
        end,
        keys = {
            { ",v", "<cmd>VenvSelect<cr>" },
        },
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
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local function on_attach(_, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
            end

            -- Go LSP
            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Python LSP (pylsp)
            lspconfig.pylsp.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                before_init = function(_, config)
                    local venv_path = os.getenv("VIRTUAL_ENV")
                    if venv_path then
                        config.cmd = { venv_path .. "/bin/pylsp" }
                    end
                end,
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = true },
                            pycodestyle = { enabled = true },
                            pylint = { enabled = false },
                            mccabe = { enabled = true },
                            yapf = { enabled = true },
                        },
                    },
                },
            })

            -- Rust LSP
            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        check = { command = "clippy" },
                        diagnostics = { enable = true },
                        cargo = { loadOutDirsFromCheck = true },
                        procMacro = { enable = true },
                    },
                },
            })

            -- C/C++ LSP
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
            })
        end,
    },
}
