local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

local servers = {
  "gopls",
  "pyright",
  "ruff_lsp",
  "tsserver",
  "eslint",
  "tailwindcss"
}

local gopls_settings = {
  analyses = {
    unusedparams = true,
    unusedwrite = false,
    unusedvariable = true,
  },
  staticcheck = false,
}

local tsserver_settings = {
  analyses = {
    unusedparams = false,
    unusedwrite = false,
    unusedvariable = false,
  },
  staticcheck = false,

  format = {
    enable = true,
  },

  complete = {
    completeFunctionCalls = true,
  },

  preferences = {
    importModuleSpecifier = "relative",
    organizeImports = {
      enable = true,
    },
  },

  diagnostics = {
    enable = true,
  },

  inlayHints = {
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = false,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
  },
}


-- local tsserver_settings = {
--   analyses = {
--     unusedparams = false,
--     unusedwrite = false,
--     unusedvariable = false,
--   },
--   staticcheck = false,
-- }

-- Disable tsserver and eslint formatting if both are present
local function on_attach_with_disable_formatting(client, bufnr)
  if client.name == "tsserver" or client.name == "eslint" then
    client.server_capabilities.documentFormattingProvider = false
  end
  on_attach(client, bufnr)
end

for _, lsp in ipairs(servers) do
  if lsp == "gopls" then
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = { gopls = gopls_settings },
      filetypes = { "go", "gomod", "gowork" },
    })
  elseif lsp == "tsserver" then
    lspconfig[lsp].setup({
      on_attach = on_attach_with_disable_formatting,
      capabilities = capabilities,
      settings = { tsserver = tsserver_settings },
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
    })
  elseif lsp == "eslint" then
    lspconfig[lsp].setup({
      on_attach = on_attach_with_disable_formatting,
      capabilities = capabilities,
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
    })
  elseif lsp == "tailwindcss" then
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
    })
  elseif lsp == "ruff_lsp" then
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "python" },
    })
  else
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {},
    })
  end
end