-- return {
--   "stevearc/conform.nvim",
--   opts = function()
--     local opts = {
--       -- LazyVim will use these options when formatting with the conform.nvim formatter
--       format = {
--         timeout_ms = 3000,
--         async = false, -- not recommended to change
--         quiet = false, -- not recommended to change
--         lsp_format = "fallback", -- not recommended to change
--       },
--       ---@type table<string, conform.FormatterUnit[]>
--       formatters_by_ft = {
--         lua = { "stylua" },
--         fish = { "fish_indent" },
--         sh = { "shfmt" },
--       },
--       -- The options you set here will be merged with the builtin formatters.
--       -- You can also define any custom formatters here.
--       ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
--       formatters = {
--         injected = { options = { ignore_errors = true } },
--         -- # Example of using dprint only when a dprint.json file is present
--         -- dprint = {
--         --   condition = function(ctx)
--         --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
--         --   end,
--         -- },
--         --
--         -- # Example of using shfmt with extra args
--         -- shfmt = {
--         --   prepend_args = { "-i", "2", "-ci" },
--         -- },
--       },
--     }
--     return opts
--   end,
-- }
--
--
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- for _, ft in ipairs(supported) do
      --   opts.formatters_by_ft[ft] = { "prettier" }
      -- end
      opts.formatters_by_ft = {
        ["ocaml"] = { "ocamlformat" },
        ["ocaml.interface"] = { "ocamlformat" },
        ["ocaml.menhir"] = { "ocamlformat" },
        ["ocaml.cram"] = { "ocamlformat" },
        ["ocaml.mlx"] = { "ocamlformat" },
        ["ocaml.ocamllex"] = { "ocamlformat" },
        ["json"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["toml"] = { "prettier" },
        ["html"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["javascript"] = { "prettier" },
        ["javascript.jsx"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescript.tsx"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["svelte"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["json5"] = { "prettier" },
        ["lua"] = { "stylua" },
        ["fish"] = { "fish_indent" },
        ["sh"] = { "shfmt" },
        ["dockerfile"] = { "dockerfilelint" },
        ["dockerfile.dockerfile"] = { "dockerfilelint" },
      }
      -- for ftype, fmtr in pairs(formatters_by_ft_temp) do
      --   opts.formatters_by_ft[ftype] = fmtr[0]
      -- end

      -- opts.formatters = opts.formatters or {}
      -- opts.formatters.prettier = {
      --   condition = function(_, ctx)
      --     return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
      --   end,
      -- }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.ocamlformat)
      table.insert(opts.sources, nls.builtins.diagnostics.mypy)
    end,
  },
}
