vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.termguicolors = true       -- True color support
opt.clipboard = "unnamedplus"  -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.expandtab = true           -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true     -- Ignore case
opt.smartcase = true      -- Don't ignore case with capitals
opt.mouse = "a"           -- Enable mouse mode
opt.number = true         -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4         -- Lines of context
opt.shiftwidth = 2        -- Size of an indent
opt.showmode = false      -- Dont show mode since we have a statusline
opt.sidescrolloff = 8     -- Columns of context
opt.smartindent = true    -- Insert indents automatically
opt.wrap = false          -- Disable line wrap
opt.splitbelow = true     -- Put new windows below current
opt.splitright = true     -- Put new windows right of current
opt.tabstop = 2           -- Number of spaces tabs count for
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.hlsearch = false
opt.incsearch = true
opt.signcolumn = "yes"
opt.updatetime = 50
opt.timeout = true
opt.timeoutlen = 300

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
