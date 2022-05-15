-- volar
local lsp_bin_path = vim.fn.stdpath "data" .. "/lsp_servers/volar/node_modules/@volar/vue-language-server/bin/vue-language-server.js"
local tsserver_path = vim.fn.stdpath "data" .. "/lsp_servers/tsserver/node_modules/typescript/bin/tsserver"
return {
  cmd = {lsp_bin_path, "--stdio"},
  filetypes = {"vue"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
  init_options = {
    documentFeatures = {
      documentColor = false,
      documentFormatting = {
        defaultPrintWidth = 100
      },
      documentSymbol = true,
      foldingRange = true,
      linkedEditingRange = true,
      selectionRange = true
    },
    languageFeatures = {
      callHierarchy = true,
      codeAction = true,
      codeLens = true,
      completion = {
        defaultAttrNameCase = "kebabCase",
        defaultTagNameCase = "both"
      },
      definition = true,
      diagnostics = true,
      documentHighlight = true,
      documentLink = true,
      hover = true,
      implementation = true,
      references = true,
      rename = true,
      renameFileRefactoring = true,
      schemaRequestService = true,
      semanticTokens = false,
      signatureHelp = true,
      typeDefinition = true
    },
    typescript = {
      serverPath = tsserver_path
    }
  }
  ,
}
