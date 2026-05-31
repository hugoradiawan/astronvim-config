-- This will run last in the setup process.

vim.keymap.set("i", "<C-x><C-o>", function() require("blink.cmp").show() end, { desc = "Show completions" })
vim.keymap.set("i", "<C-Space>", function() require("blink.cmp").show() end, { desc = "Show completions" })

vim.opt.scrolloff = 999         -- cursor stays centered vertically

-- Maximize screen real estate
vim.opt.cmdheight = 0       -- hide command line when not in use
vim.opt.laststatus = 3      -- single global statusline
vim.opt.showtabline = 2     -- always show tabline

-- Numbered float terminals
for i = 1, 5 do
  vim.keymap.set("n", "<leader>t" .. i, "<cmd>" .. i .. "ToggleTerm direction=float<cr>", { desc = "Terminal " .. i })
end

-- Neovide fullscreen (no-op in terminal)
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h13"
  vim.g.neovide_fullscreen = false
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  vim.keymap.set("n", "<C-=>", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) + 0.1
  end, { desc = "Increase font scale" })
  vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) - 0.1
  end, { desc = "Decrease font scale" })
end
