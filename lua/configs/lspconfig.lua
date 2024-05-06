-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
-- pyright
lspconfig.pyright.setup({
  -- on_attach = function(client)
  --   client.resolved_capabilities.signature_help = false
  -- end,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})
-- Rlang 
lspconfig.r_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- cmd = {"R", "--slave", "-e", "languageserver::run()"},
  -- filetypes = {"r", "rmd"},
  -- log_level = {2}
})
-- C
lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"clangd", "--background-index"},
  filetypes = {"c", "cpp", "objc", "objcpp"},
  root_dir = function() return vim.loop.cwd() end,
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
})
