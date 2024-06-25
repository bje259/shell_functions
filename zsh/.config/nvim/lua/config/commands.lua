-- ~/.config/nvim/lua/config/commands.lua

vim.api.nvim_create_user_command('OpenInMacDown', function()
    vim.fn.system('open -a MacDown ' .. vim.fn.shellescape(vim.fn.expand('%:p')))
end, {})