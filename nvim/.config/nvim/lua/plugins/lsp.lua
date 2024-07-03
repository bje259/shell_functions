return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      -- Note:
      --     the default search path for `require` is ~/.config/nvim/lua
      --     use a `.` as a path seperator
      --     the suffix `.lua` is not needed
      require("config.mason-null-ls")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "ocaml",
      })
    end,
  },
}
