---@type LazySpec
return {
  {
    "artemave/workspace-diagnostics.nvim",
    cmd = "WorkspaceDiagnostics",
    config = function()
      vim.api.nvim_create_user_command("WorkspaceDiagnostics", function()
        local client = vim.lsp.get_clients({ bufnr = 0 })[1]
        if client then
          require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
        end
      end, { desc = "Populate workspace diagnostics" })
    end,
  },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      closing_tags = {
        highlight = "Comment",
        prefix = "// ",
        enabled = true,
      },
      lsp = {
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = true
        end,
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      },
    },
  },
}
