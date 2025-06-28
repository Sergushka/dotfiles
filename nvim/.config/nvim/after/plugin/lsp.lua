vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  -- Create a function that lets us more easily define mappings specific LSP related items.
  -- It sets the mode, buffer and description for us each time.
  callback = function(event)
    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-T>.

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Enable the following language servers
local servers = {
  lua_ls = {},
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          mccabe = { enabled = false },
          pylsp_mypy = { enabled = false },
          pylsp_black = { enabled = false },
          pylsp_isort = { enabled = false },
        },
      },
    },
  },
  ruff = {
    commands = {
      RuffAutofix = {
        function()
          vim.lsp.buf.execute_command({
            command = "ruff.applyAutofix",
            arguments = {
              { uri = vim.uri_from_bufnr(0) },
            },
          })
        end,
        description = "Ruff: Fix all auto-fixable problems",
      },
      RuffOrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "ruff.applyOrganizeImports",
            arguments = {
              { uri = vim.uri_from_bufnr(0) },
            },
          })
        end,
        description = "Ruff: Format imports",
      },
    },
  },
}

-- Ensure the servers and tools above are installed
require("mason").setup()

-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua",       -- Used to format lua code
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      require("lspconfig")[server_name].setup(server)
    end,
  },
})

-- Turn on lsp status information
require('fidget').setup()

-- Python virtual env detection
-- local util = require("lspconfig/util")
-- local path = util.path
-- local function file_exists(name)
--   local f=io.open(name,"r")
--   if f~=nil then io.close(f) return true else return false end
-- end
-- local function get_python_path(workspace)
--   -- Use activated virtualenv.
--   if vim.env.VIRTUAL_ENV then
--     return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
--   end
--
--   -- Find and use virtualenv in workspace directory.
--   for _, pattern in ipairs({ "*", ".*" }) do
--     local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
--     if match ~= "" then
--       return path.join(path.dirname(match), "bin", "python")
--     end
--   end
--
--   default_venv_path = path.join(vim.env.HOME, "virtualenvs", "nvim-venv", "bin", "python")
--   if file_exists(default_venv_path) then
--     return default_venv_path
--   end
--
--   -- Default virtual environment
-- --   return path.join(vim.env.HOME, "virtualenvs", "nvim-venv", "bin", "python")
--
--   -- Fallback to system Python.
--   return exepath("python3") or exepath("python") or "python"
--
-- end
--
-- require('lspconfig').pyright.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   before_init = function(_, config)
--     config.settings.python.pythonPath = get_python_path(config.root_dir)
--   end,
-- }


-- nvim-cmp setup
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")
luasnip.config.setup({})

local kind_icons = {
  Text = "󰉿",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰆧",
  Class = "󰌗",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰇽",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = "menu,menuone,noinsert" },
  -- window = {
  --     completion = cmp.config.window.bordered(),
  --     documentation = cmp.config.window.bordered(),
  -- },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),        -- Select the [n]ext item
    ["<C-p>"] = cmp.mapping.select_prev_item(),        -- Select the [p]revious item
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept the completion with Enter.
    ["<C-c>"] = cmp.mapping.complete({}),              -- Manually trigger a completion from nvim-cmp.

    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

    -- Select next/previous item with Tab / Shift + Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
})
