-- This will run last in the setup process.

-- Native LSP info command (replaces lspconfig's :LspInfo)
vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSP clients attached to this buffer", vim.log.levels.WARN)
    return
  end
  local lines = {}
  for _, client in ipairs(clients) do
    table.insert(lines, string.format("● %s (id=%d)", client.name, client.id))
    table.insert(lines, string.format("  root: %s", client.root_dir or "none"))
    table.insert(lines, string.format("  filetypes: %s", table.concat(client.config.filetypes or {}, ", ")))
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "LSP Clients" })
end, { desc = "Show attached LSP clients" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { buffer = args.buf, desc = "LSP code actions" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code actions" })
  end,
})
vim.keymap.set("i", "<C-x><C-o>", function() require("blink.cmp").show() end, { desc = "Show completions" })
vim.keymap.set("i", "<C-Space>", function() require("blink.cmp").show() end, { desc = "Show completions" })

vim.opt.scrolloff = 999         -- cursor stays centered vertically

-- Maximize screen real estate
vim.opt.cmdheight = 0       -- hide command line when not in use
vim.opt.laststatus = 3      -- single global statusline
vim.opt.showtabline = 2     -- always show tabline

-- Dedicated terminals
local Terminal = require("toggleterm.terminal").Terminal
local claude_term = Terminal:new({ cmd = "claude", direction = "float", hidden = true })
local frun_term = Terminal:new({
  cmd = "frun",
  direction = "vertical",
  hidden = true,
  size = 120,
  on_open = function(term) vim.api.nvim_win_set_width(term.window, 120) end,
})
vim.keymap.set("n", "<leader>t1", function() claude_term:toggle() end, { desc = "Terminal: claude (float)" })
vim.keymap.set("n", "<leader>t2", function() frun_term:toggle() end, { desc = "Terminal: frun (vertical)" })

-- Numbered float terminals
for i = 3, 5 do
  vim.keymap.set("n", "<leader>t" .. i, "<cmd>" .. i .. "ToggleTerm direction=float<cr>", { desc = "Terminal " .. i })
end

-- Neovide fullscreen (no-op in terminal)
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h13"
  vim.opt.clipboard = "unnamedplus"
  local function paste()
    vim.api.nvim_paste(vim.fn.getreg "+", true, -1)
  end
  vim.keymap.set("n", "<C-q>", "<C-v>", { desc = "Visual block mode" })
  vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste" })
  vim.keymap.set("i", "<C-v>", paste, { desc = "Paste" })
  vim.keymap.set("c", "<C-v>", "<C-R>+", { desc = "Paste" })
  vim.keymap.set("t", "<C-v>", '<C-\\><C-N>"+pi', { desc = "Paste" })
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

-- Open dashboard when launched with a directory arg (e.g. desktop shortcut)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      local dir = vim.fn.argv(0)
      vim.cmd("cd " .. vim.fn.fnameescape(dir))
      vim.schedule(function()
        require("snacks").dashboard.open()
      end)
    end
  end,
})
