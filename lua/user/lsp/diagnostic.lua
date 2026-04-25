local M = {}

M.setup_ui = function()
    local signs = {
      { name = "DiagnosticSignError", text = "󰅙 " },
      { name = "DiagnosticSignWarn",  text = " " },
      { name = "DiagnosticSignHint",  text = " " },
      { name = "DiagnosticSignInfo",  text = " " },
    }
    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local diagnostic_config = {
      virtual_text = {
        source = "always",
      },
      -- show signs
      signs = {
        active = signs,
      },
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      underline = true,
      update_in_insert = true,
      severity_sort = true,
    }
    vim.diagnostic.config(diagnostic_config)
end
return M
