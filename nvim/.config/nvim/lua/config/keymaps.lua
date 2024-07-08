-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Resize window using <ctrl> arrow keys
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

vim.keymap.set("n", "<S-F5>", '<cmd>lua require"dap".continue()<CR>', { desc = "dap-continue" }) -- Start/continue
vim.keymap.set("n", "<S-F10>", '<cmd>lua require"dap".step_over()<CR>', { desc = "dap-stepover" }) -- Step over
vim.keymap.set("n", "<S-F11>", '<cmd>lua require"dap".step_into()<CR>', { desc = "dap-stepinto" }) -- Step into
vim.keymap.set("n", "<S-F12>", '<cmd>lua require"dap".step_out()<CR>', { desc = "dap-stepout" }) -- Step out

vim.keymap.set("n", "<leader>T", "<cmd>Telescope<CR>", { desc = "Telescope" })

-- Map <C-n> to toggle NERDTree
-- vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Map <leader>p to open Files
-- vim.api.nvim_set_keymap('n', '<leader>p', ':Files<CR>', { noremap = true, silent = true })

-- Map <Leader><Leader> to clear search highlighting
vim.api.nvim_set_keymap("n", "<Leader><Leader>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- mapping = cmp.mapping.preset.insert({
--      ['<C-l>'] = cmp.mapping.complete(),
--  }),
--
