-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("i", "<C-BS>", "<Esc>cvb", {})

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
}
