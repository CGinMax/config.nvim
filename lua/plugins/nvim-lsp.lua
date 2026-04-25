-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig

return {
  "neovim/nvim-lspconfig",
  -- events = { "BufReadPost" },
  events = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUnintall", "Mason" },
  dependencies = {
    -- Plugin and UI to automatically install LSPs to stdpath
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/cmp-nvim-lsp",

    -- Progress/Status update for LSP
    { "j-hui/fidget.nvim", tag = "legacy" },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        border = "rounded",
      },
      log_level = vim.log.levels.ERROR,
      max_concurrent_installers = 6,
    })

    local custom_lsp_handlers = require("user.lsp.handlers")
    mason_lspconfig.setup({
      handlers = custom_lsp_handlers.handlers,
      automatic_installation = { exclude = { "ocamlisp", "gleam" } }
    })

    require("lspconfig.ui.windows").default_options.border = "rounded"

    local custom_lsp_diagnostic = require("user.lsp.diagnostic")
    custom_lsp_diagnostic.setup_ui()


  end,
}
