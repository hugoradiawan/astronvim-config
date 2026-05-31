---@type LazySpec
return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "File diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace diagnostics" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location list" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix list" },
    },
    opts = {
      focus = true,
      win = {
        type = "split",
        position = "right",
        size = 60,
      },
    },
  },
}
