---@type LazySpec
return {
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
