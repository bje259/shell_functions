return {

  -- Add BibTeX/LaTeX to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "latex", "bibtex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },

  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex" },
    },
  },

  -- Correctly setup lspconfig for LaTeX 🚀
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          keys = {
            { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
          },
        },
      },
    },
  },

  -- Add asyncrun for asynchronous compilation
  {
    "skywind3000/asyncrun.vim",
    lazy = false, -- Ensure it loads with Neovim
    config = function()
      vim.cmd([[
        command! -nargs=0 RunLatex AsyncRun latexmk -pdf %
      ]])
    end,
  },
}
