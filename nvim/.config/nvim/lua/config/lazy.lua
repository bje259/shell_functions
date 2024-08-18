local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend("/opt/homebrew/opt/fzf")
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        -- "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Ensure which-key is loaded
local wk = require("which-key")

-- Define a function to open a new buffer and set the filetype
local function new_buffer_with_filetype(ft)
  vim.cmd("enew") -- Open a new buffer
  vim.cmd("setfiletype " .. ft) -- Set the filetype
end

local function set_filetype(ft)
  vim.cmd("setfiletype " .. ft)
end
-- Register the keybindings with which-key
wk.add({
  {
    mode = "n",
    "<leader>t",
    group = "filetype",
    {
      "<leader>tj",
      function()
        set_filetype("json")
      end,
      desc = "Set filetype to JSON",
    },
    {
      "<leader>tl",
      function()
        set_filetype("lua")
      end,
      desc = "Set filetype to Lua",
    },
    {
      "<leader>tp",
      function()
        set_filetype("python")
      end,
      desc = "Set filetype to Python",
    },
    {
      "<leader>th",
      function()
        set_filetype("html")
      end,
      desc = "Set filetype to HTML",
    },
    {
      "<leader>tz",
      function()
        set_filetype("zsh")
      end,
      desc = "Set filetype to Zsh",
    },
    {
      "<leader>to",
      function()
        set_filetype("ocaml")
      end,
      desc = "Set filetype to Ocaml",
    },

    {
      mode = "n",
      {
        "<leader>tn",
        group = "temporary new buffer",
        {
          {
            "<leader>tnj",
            function()
              new_buffer_with_filetype("json")
            end,
            desc = "New buffer with JSON",
          },
          {
            "<leader>tnl",
            function()
              new_buffer_with_filetype("lua")
            end,
            desc = "New buffer with Lua",
          },
          {
            "<leader>tnp",
            function()
              new_buffer_with_filetype("python")
            end,
            desc = "New buffer with Python",
          },
          {
            "<leader>tnh",
            function()
              new_buffer_with_filetype("html")
            end,
            desc = "New buffer with HTML",
          },
          {
            "<leader>tnz",
            function()
              new_buffer_with_filetype("zsh")
            end,
            desc = "Set filetype to Zsh",
          },
          {
            "<leader>tno",
            function()
              new_buffer_with_filetype("ocaml")
            end,
            desc = "Set filetype to Ocaml",
          },
        },
      },
    },
  },
})
--   tn = {
--     name = "Temporary New Filetypes",
--     j = {
--       function()
--         new_buffer_with_filetype("json")
--       end,
--       "New buffer with JSON",
--     },
--     l = {
--       function()
--         new_buffer_with_filetype("lua")
--       end,
--       "New buffer with Lua",
--     },
--     p = {
--       function()
--         new_buffer_with_filetype("python")
--       end,
--       "New buffer with Python",
--     },
--     h = {
--       function()
--         new_buffer_with_filetype("html")
--       end,
--       "New buffer with HTML",
--     },
--     z = {
--       function()
--         new_buffer_with_filetype("zsh")
--       end,
--       "Set filetype to Zsh",
--     },
--     -- Add more filetypes as needed
--   },
-- },

-- wk.register({
--   tn = {
--     name = "Temporary New Filetypes",
--     j = {
--       function()
--         new_buffer_with_filetype("json")
--       end,
--       "New buffer with JSON",
--     },
--     l = {
--       function()
--         new_buffer_with_filetype("lua")
--       end,
--       "New buffer with Lua",
--     },
--     p = {
--       function()
--         new_buffer_with_filetype("python")
--       end,
--       "New buffer with Python",
--     },
--     h = {
--       function()
--         new_buffer_with_filetype("html")
--       end,
--       "New buffer with HTML",
--     },
--     z = {
--       function()
--         new_buffer_with_filetype("zsh")
--       end,
--       "Set filetype to Zsh",
--     },
--
--     -- Add more filetypes as needed
--   },
-- }, { prefix = "<leader>" }) -- Ensure which-key is loaded
--
-- local wk = require("which-key")
--
-- Define a function to set filetype
--
-- Register the keybindings with which-key
-- wk.add({
--   ["<leader>"] = {
--     t = {
--       name = "Set Filetypes",
--       j = {
--         function()
--           new_buffer_with_filetype("json")
--         end,
--         "New buffer with JSON",
--       },
--       l = {
--         function()
--           new_buffer_with_filetype("lua")
--         end,
--         "New buffer with Lua",
--       },
--       p = {
--         function()
--           new_buffer_with_filetype("python")
--         end,
--         "New buffer with Python",
--       },
--       h = {
--         function()
--           new_buffer_with_filetype("html")
--         end,
--         "New buffer with HTML",
--       },
--       z = {
--         function()
--           new_buffer_with_filetype("zsh")
--         end,
--         "Set filetype to Zsh",
--       },
--       -- Add more filetypes as needed
--     },
--   },
-- })

-- wk.register({
--   t = {
--     name = "Temporary Filetypes",
--     j = {
--       function()
--         set_filetype("json")
--       end,
--       "Set filetype to JSON",
--     },
--     l = {
--       function()
--         set_filetype("lua")
--       end,
--       "Set filetype to Lua",
--     },
--     p = {
--       function()
--         set_filetype("python")
--       end,
--       "Set filetype to Python",
--     },
--     h = {
--       function()
--         set_filetype("html")
--       end,
--       "Set filetype to HTML",
--     },
--     z = {
--       function()
--         set_filetype("zsh")
--       end,
--       "Set filetype to Zsh",
--     },
--     -- Add more filetypes as needed
--   },
-- }, { prefix = "<leader>" })
--
-- Define the function to diff with a register

-- Define the function to diff with a register
-- _G.diff_with_register = function(register)
--   -- Yank selected text to register 'z'
--   vim.cmd("normal! y")
--
--   -- Open a new vertical split and create a new empty buffer
--   vim.cmd("vsplit")
--   vim.cmd("enew")
--
--   -- Put the contents of the specified register into the new buffer
--   vim.cmd("put " .. register)
--
--   -- Set the buffer type to nofile
--   vim.bo.buftype = "nofile"
--
--   -- Enable diff mode for the new buffer
--   vim.cmd("diffthis")
--
--   -- Switch back to the original window
--   vim.cmd("wincmd p")
--
--   -- Put the contents of register 'z' in the original buffer
--   vim.cmd("put +")
--
--   -- Enable diff mode for the original buffer
--   vim.cmd("diffthis")
-- end
--
-- -- Map the function to a key combination for easy usage in visual mode
-- vim.api.nvim_set_keymap("x", "<leader>fd", [[:lua diff_with_register('*')<CR>]], { noremap = true, silent = true })

-- Define the function to diff with a register
_G.diff_with_register = function(register)
  -- Yank selected text to register 'z'
  -- vim.cmd('normal! "ay')

  -- Save the filetype of the current buffer
  local filetype = vim.bo.filetype

  -- Open a new vertical split and create a new empty buffer
  vim.cmd("vsplit")
  vim.cmd("enew")

  -- Put the contents of the specified register into the new buffer
  vim.cmd("put " .. register)

  -- Set the buffer type to nofile
  vim.bo.buftype = "nofile"

  -- Apply the filetype to the new buffer
  vim.cmd("setlocal filetype=" .. filetype)

  -- Enable diff mode for the new buffer
  vim.cmd("diffthis")

  -- Switch back to the original window
  vim.cmd("wincmd p")

  -- vim.cmd("normal! g")
  -- Put the contents of register 'z' in the original buffer
  -- vim.cmd("put +")

  -- Enable diff mode for the original buffer
  vim.cmd("diffthis")
end

-- Map the function to a key combination for easy usage in visual mode
vim.api.nvim_set_keymap("x", "<leader>fd", [[:lua _G.diff_with_register('+')<CR>]], { noremap = true, silent = true })
