-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Diagnostic
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Hover [d]iagnostic' })

-- oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- lsp
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover Documentation' })
vim.keymap.set('i', '<C-p>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature help' })

vim.keymap.set('n', '<leader>k', ':bdelete<CR>', { buffer = bufnr, desc = '[k]ill buffer' })
vim.keymap.set('n', '<leader>K', ':bdelete!<CR>', { buffer = bufnr, desc = '[K]ill buffer (unsaved)' })

-- buffer
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { buffer = bufnr, desc = 'Goto [b]uffer [n]ext' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { buffer = bufnr, desc = 'Goto [b]uffer [p]revious' })

-- remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- aditional remaps
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move lines up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'Window left' })
vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'Window right' })
vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'Window down' })
vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'Window up' })

--git remaps
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { noremap = true, desc = 'Open Lazy [g]it' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
