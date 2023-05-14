local prettier = require("prettier")

prettier.setup {
  bin = "prettierd",
  filetypes = {
    "css",
    "javascript",
    "typescript",
    "json"
  }
}

return prettier
