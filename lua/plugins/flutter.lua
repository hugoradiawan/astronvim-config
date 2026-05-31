---@type LazySpec
return {
  {
    "artemave/workspace-diagnostics.nvim",
    event = "LspAttach",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          require("workspace-diagnostics").populate_workspace_diagnostics(
            vim.lsp.get_client_by_id(args.data.client_id),
            args.buf
          )
        end,
      })
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
    },
  },
}
