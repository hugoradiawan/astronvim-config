-- This will run last in the setup process.

vim.opt.scrolloff = 999         -- cursor stays centered vertically

-- Maximize screen real estate
vim.opt.cmdheight = 0       -- hide command line when not in use
vim.opt.laststatus = 3      -- single global statusline
vim.opt.showtabline = 1     -- show tabline only when >1 tab

-- Numbered float terminals
for i = 1, 5 do
  vim.keymap.set("n", "<leader>t" .. i, "<cmd>" .. i .. "ToggleTerm direction=float<cr>", { desc = "Terminal " .. i })
end

-- Neovide fullscreen (no-op in terminal)
if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
end
