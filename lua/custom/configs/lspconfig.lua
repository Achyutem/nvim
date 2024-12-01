local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local servers = {
    "gopls",
    "pyright",
    -- "ruff_lsp",
    -- "ts-sl",
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
    format = { enable = false },
    complete = { completeFunctionCalls = true },
    preferences = {
        importModuleSpecifier = "relative",
        organizeImports = { enable = true },
    },
    diagnostics = { enable = true },
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

-- Define common filetypes to avoid redundancy
local js_ts_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "jsx", "tsx" }

-- Servers with formatting disabled
local servers_with_disabled_formatting = {
    ["tsserver"] = true,
    ["eslint"] = true,
}

local function on_attach_conditional(client, bufnr)
    -- Disable formatting for specified servers
    if servers_with_disabled_formatting[client.name] then
        client.server_capabilities.documentFormattingProvider = false
    end

    -- Call the default on_attach function
    on_attach(client, bufnr)
end

local common_setup = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local function custom_lsp_setup(lsp, opts)
    lspconfig[lsp].setup(vim.tbl_extend('force', common_setup, opts))
end

for _, lsp in ipairs(servers) do
    if lsp == "gopls" then
        custom_lsp_setup(lsp, {
            settings = { gopls = gopls_settings },
            filetypes = { "go", "gomod", "gowork" },
        })
    elseif lsp == "tsserver" then
        custom_lsp_setup(lsp, {
            on_attach = on_attach_conditional,
            settings = { tsserver = tsserver_settings },
            filetypes = js_ts_filetypes,
        })
    elseif lsp == "eslint" then
        custom_lsp_setup(lsp, {
            on_attach = on_attach_conditional,
            filetypes = js_ts_filetypes,
        })
    elseif lsp == "tailwindcss" then
        custom_lsp_setup(lsp, {
            filetypes = { "html", "css", "scss", unpack(js_ts_filetypes), "svelte" },
        })
    elseif lsp == "ruff_lsp" then
        custom_lsp_setup(lsp, {
            filetypes = { "python" },
        })
    elseif lsp == "pyright" then
        custom_lsp_setup(lsp, {
            filetypes = { "python" },
        })
    else
        custom_lsp_setup(lsp, {})
    end
end
