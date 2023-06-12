-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup({
                size = 20,
                open_mapping = [[<c-h>]],
                hide_numbers = true, -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
                start_in_insert = true,
                persist_size = true,
                direction = "horizontal",
                close_on_exit = true, -- close the terminal window when the process exits
                insert_mappings = false,
                shell = vim.o.shell,
                -- This field is only relevant if direction is set to 'float'
                float_opts = {
                    -- The border key is *almost* the same as 'nvim_win_open'
                    -- see :h nvim_win_open for details on borders however
                    -- the 'curved' border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    border = "curved",
                    -- width = <value>,
                    -- height = <value>,
                    winblend = 3,
                    highlights = { border = 'Normal', background = 'Normal' },
                },
            })
        end,
    },
    {
        'echasnovski/mini.pairs',
        opts = {
            mappings = {
                -- restrict ' with < and & for rust
                ["'"] = { neigh_pattern = "[^%a\\|<|&]." },
                -- Add | for rust iterations
                ["|"] = {
                    action = "closeopen",
                    pair = "||",
                    neigh_pattern = "[(][)]",
                    register = { cr = false }
                },
            },
        },
    },
    {
        'catppuccin/nvim',
        config = function()
            vim.cmd.colorscheme 'catppuccin-mocha'
        end
    },
    {
        'tpope/vim-surround'
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup()
        end
    }
}
