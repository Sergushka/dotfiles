local lspconfig = require("lspconfig")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function() return vim.loop.cwd() end
})

lspconfig.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
