local M = {}

M.centeral = {
  plugin = true,
  n = {
    ["<C-d>"] = { "<C-d>zz", "Go down and center" },
    ["<C-u>"] = { "<C-u>zz", "Go up and center" },
    ["n"] = { "nzzzv", "Go to next word and center" },
    ["N"] = { "Nzzzv", "Go to previous word and center" },
  },
  v = {
    ["J"] = {":m '>+1<CR>gv=gv", "Move lines down"},
    ["K"] = {":m '<-2<CR>gv=gv", "Move lines up"},
  },
}
return M
