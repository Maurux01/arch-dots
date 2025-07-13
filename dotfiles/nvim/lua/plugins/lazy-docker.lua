return {
  -- Docker file syntax highlighting
  {
    "ekalinin/Dockerfile.vim",
    ft = { "Dockerfile", "dockerfile" },
  },

  -- Docker compose syntax highlighting
  {
    "mattn/vim-go",
    ft = { "go" },
  },

  -- Docker integration with telescope (simplified)
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fd", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
  },
} 