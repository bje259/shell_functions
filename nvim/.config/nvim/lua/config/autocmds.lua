-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
vim.cmd([[
  autocmd BufRead,BufNewFile *.mli setfiletype ocamlinterface
]])

-- Debugging: Print the filetype when opening a .mli file
vim.cmd([[
  autocmd BufRead,BufNewFile *.mli lua print("Filetype: " .. vim.bo.filetype)
]])
