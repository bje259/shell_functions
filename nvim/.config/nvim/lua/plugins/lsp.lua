return {
  {
    "tjdevries/ocaml.nvim",
    config = function()
      -- Register various ocaml related syntax extensions
      vim.filetype.add({
        extension = {
          mli = "ocamlinterface", -- Changed this line
          mly = "ocaml.menhir",
          mll = "ocaml.ocamllex",
          mlx = "ocaml",
          t = "ocaml.cram",
        },
      })

      -- If you have `ocaml_interface` parser installed, it will use it for `ocamlinterface` files
      vim.treesitter.language.register("ocaml_interface", "ocamlinterface") -- Changed this line
      vim.treesitter.language.register("menhir", "ocaml.menhir")
      vim.treesitter.language.register("cram", "ocaml.cram")
      vim.treesitter.language.register("ocamllex", "ocaml.ocamllex")
    end,
  },
  { "tjdevries/lsp_extensions.nvim" },
  { "tjdevries/nlua.nvim" },
  --   {"neovim/nvim-lspconfig",
  --     config = function()
  --         local servers = {
  --           ocamllsp = {
  --           manual_install = true,
  --           settings = {
  --             codelens = { enable = true },
  --             inlayHints = { enable = true },
  --             syntaxDocumentation = { enable = true },
  --           },
  --         get_language_id = function(_, ftype)
  --           return ftype
  --         end,
  --
  --           -- get_language_id = function(lang)
  --           --   local map = {
  --           --     ["ocaml.mlx"] = "mlx",
  --           --   }
  --           --   return map[lang] or lang
  --           -- end,
  --
  --           filetypes = {
  --             "ocaml",
  --             "ocaml.interface",
  --             "ocaml.menhir",
  --             "ocaml.cram",
  --             "ocaml.mlx",
  --             "ocaml.ocamllex",
  --           },
  --
  --           server_capabilities = {
  --             semanticTokensProvider = false,
  --           },
  --             },
  --             },
  --     end,
  -- },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
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
