return {
    "nvim-neo-tree/neo-tree.nvim",
    --tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- Not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
    require('neo-tree').setup {}
        require('neo-tree').setup {
            auto_close = true,
            update_cwd = true,
            filesystem = {
                filtered_items = {
                    visible = true,
                    show_hidden_count = true,
                     hide_dotfiles = false,
                     hide_gitignored = true,
                    -- hide_by_name = {
                    --     '.git',
                    --     '.DS_Store',
                    --     'thumbs.db',
                    -- },
                    never_show = {},
                },
            }
        }
    end
}

