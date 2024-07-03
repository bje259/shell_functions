local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
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

-- Register the keybindings with which-key
wk.register({
  tn = {
    name = "Temporary New Filetypes",
    j = {
      function()
        new_buffer_with_filetype("json")
      end,
      "New buffer with JSON",
    },
    l = {
      function()
        new_buffer_with_filetype("lua")
      end,
      "New buffer with Lua",
    },
    p = {
      function()
        new_buffer_with_filetype("python")
      end,
      "New buffer with Python",
    },
    h = {
      function()
        new_buffer_with_filetype("html")
      end,
      "New buffer with HTML",
    },
    z = {
      function()
        new_buffer_with_filetype("zsh")
      end,
      "Set filetype to Zsh",
    },

    -- Add more filetypes as needed
  },
}, { prefix = "<leader>" }) -- Ensure which-key is loaded

-- local wk = require("which-key")
--
-- Define a function to set filetype
local function set_filetype(ft)
  vim.cmd("setfiletype " .. ft)
end
--
-- Register the keybindings with which-key
wk.register({
  t = {
    name = "Temporary Filetypes",
    j = {
      function()
        set_filetype("json")
      end,
      "Set filetype to JSON",
    },
    l = {
      function()
        set_filetype("lua")
      end,
      "Set filetype to Lua",
    },
    p = {
      function()
        set_filetype("python")
      end,
      "Set filetype to Python",
    },
    h = {
      function()
        set_filetype("html")
      end,
      "Set filetype to HTML",
    },
    z = {
      function()
        set_filetype("zsh")
      end,
      "Set filetype to Zsh",
    },
    -- Add more filetypes as needed
  },
}, { prefix = "<leader>" })
