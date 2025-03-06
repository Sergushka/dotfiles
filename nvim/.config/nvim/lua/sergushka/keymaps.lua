-- Telescope maps
vim.keymap.set("n", "<leader>f", ":Telescope file_browser path=%:p:h<CR>", { noremap = true, desc = "[f]ile browser" })
vim.keymap.set("n", "<leader>t", ":Telescope find_files<CR>", { noremap = true, desc = "find files" })
vim.keymap.set("n", "<leader>b", ":Telescope buffers show_all_buffers=true<CR>", { noremap = true, desc = "[b]uffers" })
vim.keymap.set(
  "n",
  "<leader>cs",
  ":Telescope lsp_document_symbols<CR>",
  { noremap = true, desc = "Document [s]ymbols" }
)
vim.keymap.set("n", "<leader>l", ":Telescope live_grep<CR>", { noremap = true, desc = "[l]ive grep" })
vim.keymap.set("n", "<leader>F", ":Telescope filetypes<CR>", { noremap = true, desc = "[F]iletypes list" })

-- Diagnostic
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Hover [d]iagnostic" })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle loclist<CR>", { desc = "Location list" })
vim.keymap.set(
  "n",
  "<leader>xt",
  "<cmd>TroubleToggle quickfix<CR>",
  { silent = true, noremap = true, desc = "Open trouble quickfix" }
)
vim.keymap.set("n", "<leader>xD", ":Telescope diagnostics<CR>", { noremap = true, desc = "[D]iagnostics list" })

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover Documentation" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP [r]ename" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { buffer = bufnr, desc = "LSP [f]ormat" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code [a]ction" })
vim.keymap.set("i", "<C-p>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })

vim.keymap.set("n", "<leader>k", ":bdelete<CR>", { buffer = bufnr, desc = "[k]ill buffer" })
vim.keymap.set("n", "<leader>K", ":bdelete!<CR>", { buffer = bufnr, desc = "[K]ill buffer (unsaved)" })
vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { buffer = bufnr, desc = "[z]en mode" })

-- Debugger
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "[d]ebugger [b]reak point" })
vim.keymap.set("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "[d]ebugger [c]ontinue" })
vim.keymap.set("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "[d]ebugger [s]tep into" })

-- goto maps
vim.keymap.set("n", "gbn", ":bnext<CR>", { buffer = bufnr, desc = "Goto [b]uffer [n]ext" })
vim.keymap.set("n", "gbp", ":bprevious<CR>", { buffer = bufnr, desc = "Goto [b]uffer [p]revious" })
vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", { buffer = bufnr, desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "gI", ":Telescope lsp_implementations<CR>", { buffer = bufnr, desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "<leader>D", ":Telescope lsp_type_definitions<CR>", { buffer = bufnr, desc = "Type [D]efinition" })
vim.keymap.set("n", "<leader>ds", ":Telescope lsp_document_symbols<CR>", { buffer = bufnr, desc = "[D]ocument [S]ymbols" })
vim.keymap.set(
  "n",
  "<leader>ws",
  ":Telescope lsp_dynamic_workspace_symbols<CR>",
  { buffer = bufnr, desc = "[W]orkspace [S]ymbols" }
)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "[G]oto [D]eclaration" })

-- remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- aditional remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move lines up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Window up" })

--git remaps
vim.keymap.set("n", "<leader>g", ":LazyGit<CR>", { noremap = true, desc = "Open Lazy [g]it" })

--neotest
vim.keymap.set("n", "<leader>ctr", ":Neotest run run<CR>", { noremap = true, desc = "Run current test" })
vim.keymap.set("n", "<leader>cts", ":Neotest summary<CR>", { noremap = true, desc = "Run current test" })
