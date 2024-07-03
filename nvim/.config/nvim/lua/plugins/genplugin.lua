return {
  { "theprimeagen/vim-be-good" },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "agoodshort/telescope-git-submodules.nvim",
        dependencies = "akinsho/toggleterm.nvim",
      },
    },
    config = function()
      require("telescope").load_extension("git_submodules")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
