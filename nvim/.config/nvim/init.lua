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
	{ "folke/neodev.nvim",                      opts = {} },
	{ "numToStr/Comment.nvim",                  opts = {} },
	{ "folke/which-key.nvim",                   opts = {} },
	{ "stevearc/dressing.nvim",                 event = "VeryLazy" },
	{ "RRethy/vim-illuminate" },
	{ 'nvim-treesitter/nvim-treesitter-context' },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-surround" },
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup {}
		end
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require('leap').add_default_mappings()
		end
	},
	{
		'echasnovski/mini.pairs',
		version = false,
		config = function()
			require('mini.pairs').setup()
		end
	},
	{
		'echasnovski/mini.indentscope',
		version = false,
		config = function()
			require('mini.indentscope').setup()
		end
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup {}
		end
	},
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup {
				highlight = {
					pattern = [[.*<(KEYWORDS)\s* ]]
				},
				search = {
					pattern = [[\b(KEYWORDS)\b]],
				}
			}
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = 'top',
					},
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-a>"] = actions.toggle_selection,

							["<Tab>"] = actions.move_selection_next,
							["<S-Tab>"] = actions.move_selection_previous,
						},
					},
				},
			})
			telescope.load_extension("file_browser")
		end
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim",          config = true },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim",                opts = {},    tag = 'legacy' },
			{ "folke/neodev.nvim" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer" },
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_c = {
					{
						'filename',
						path = 1,
					}
				},
				lualine_x = {
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				}
			}
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "»",
			show_trailing_blankline_indent = false,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	{
		'folke/tokyonight.nvim',
		config = function()
			require('tokyonight').setup({
				style = "night",
				on_colors = function(colors)
					colors.bg = "#08080b"
				end,
				on_highlights = function(highlights, colors)
					highlights.DiagnosticUnderlineError = {
						undercurl = false
					}
					highlights.DiagnosticUnderlineHint = {
						undercurl = false
					}
					highlights.DiagnosticUnderlineInfo = {
						undercurl = false
					}
					highlights.DiagnosticUnderlineWarn = {
						undercurl = false
					}
				end
			})
			vim.cmd [[colorscheme tokyonight]]
		end
	},
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		'christoomey/vim-tmux-navigator'
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			'mfussenegger/nvim-dap'
		},
		opts = {
			handlers = {},
			ensure_installed = {
				"codelldb"
			}
		}
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end
	}
})


-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable relative numbers
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim" },

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = false,

	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
		},
		swap = {
			enable = true,
		},
	},
})

local on_attach = function(_, bufnr)
	vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
end

local servers = {
	gopls = {},
	rust_analyzer = {},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			handlers = {
				['textDocument/hover'] = vim.lsp.with(
					vim.lsp.handlers.hover,
					{ border = 'rounded' }
				)

			}
		})
	end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")

local unlinkgrp = vim.api.nvim_create_augroup(
	'UnlinkSnippetOnModeChange',
	{ clear = true }
)

vim.api.nvim_create_autocmd('ModeChanged', {
	group = unlinkgrp,
	pattern = { 's:n', 'i:*' },
	desc = 'Forget the current snippet when leaving the insert mode',
	callback = function(evt)
		if
			luasnip.session
			and luasnip.session.current_nodes[evt.buf]
			and not luasnip.session.jump_active
		then
			luasnip.unlink_current()
		end
	end,
})

luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}
})

-- space maps
vim.keymap.set('n', '<leader>f', ':Telescope file_browser path=%:p:h<CR>', { noremap = true, desc = '[f]ile browser' })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true, desc = '[b]uffers' })
vim.keymap.set('n', '<leader>D', ':Telescope diagnostics<CR>', { noremap = true, desc = '[D]iagnostics list' })
vim.keymap.set('n', '<leader>s', ':Telescope lsp_document_symbols<CR>', { noremap = true, desc = 'Document [s]ymbols' })
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { noremap = true, desc = 'Open Lazy [g]it' })
vim.keymap.set('n', '<leader>S', ':Telescope lsp_workspace_symbols<CR>', { noremap = true, desc = 'Workspace [S]ymbols' })
vim.keymap.set('n', '<leader>l', ':Telescope live_grep<CR>', { noremap = true, desc = '[l]ive grep' })
vim.keymap.set('n', '<leader>F', ':Telescope filetypes<CR>', { noremap = true, desc = '[F]iletypes list' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = "Hover [d]iagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostic list" })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP [r]ename' })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP Code [a]ction' })
vim.keymap.set('n', '<leader>k', ":bdelete<CR>", { buffer = bufnr, desc = '[k]ill buffer' })
vim.keymap.set('n', '<leader>K', ":bdelete!<CR>", { buffer = bufnr, desc = '[K]ill buffer (unsaved)' })
vim.keymap.set('n', '<leader>n', ":tabnew<CR>", { buffer = bufnr, desc = '[n]ew tab' })
vim.keymap.set('n', '<leader>z', ":ZenMode<CR>", { buffer = bufnr, desc = '[z]en mode' })
vim.keymap.set('n', '<leader>db', "<cmd> DapToggleBreakpoint <CR>", { desc = '[d]ebugger [b]reak point' })
vim.keymap.set('n', '<leader>dc', "<cmd> DapContinue <CR>", { desc = '[d]ebugger [c]ontinue' })

-- goto maps
vim.keymap.set('n', 'gbn', ":bnext<CR>", { buffer = bufnr, desc = 'Goto [b]uffer [n]ext' })
vim.keymap.set('n', 'gbp', ":bprevious<CR>", { buffer = bufnr, desc = 'Goto [b]uffer [p]revious' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto [d]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto [D]eclaration' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'Goto [r]eferences' })
vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations,
	{ buffer = bufnr, desc = 'Goto [i]mplementation' })
vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions,
	{ buffer = bufnr, desc = 'Goto [t]ype Definition' })

-- remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- aditional remaps
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover Documentation' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, desc = 'Move lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, desc = 'Move lines up' })
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
vim.keymap.set('n', '<C-h>', "<cmd> TmuxNavigateLeft<CR>", { desc = 'Window left' })
vim.keymap.set('n', '<C-l>', "<cmd> TmuxNavigateRight<CR>", { desc = 'Window right' })
vim.keymap.set('n', '<C-j>', "<cmd> TmuxNavigateDown<CR>", { desc = 'Window down' })
vim.keymap.set('n', '<C-k>', "<cmd> TmuxNavigateUp<CR>", { desc = 'Window up' })
