return {
  -- LazyDocker integration
  {
    "kdheepak/lazydocker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>dd", "<cmd>LazyDocker<cr>", desc = "LazyDocker" },
      { "<leader>dc", "<cmd>LazyDockerConfig<cr>", desc = "LazyDocker Config" },
    },
    config = function()
      vim.g.lazydocker_floating_window_winblend = 0
      vim.g.lazydocker_floating_window_scaling_factor = 0.9
      vim.g.lazydocker_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.lazydocker_floating_window_use_plenary = 0
      vim.g.lazydocker_use_neovim_remote = 1
      vim.g.lazydocker_use_custom_config_file_path = 0
      vim.g.lazydocker_config_file_path = ""
    end,
  },

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

  -- Container management
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-docker.nvim",
    },
    config = function()
      require("telescope").load_extension("docker")
    end,
    keys = {
      { "<leader>fd", "<cmd>Telescope docker containers<cr>", desc = "Docker containers" },
      { "<leader>fi", "<cmd>Telescope docker images<cr>", desc = "Docker images" },
      { "<leader>fv", "<cmd>Telescope docker volumes<cr>", desc = "Docker volumes" },
      { "<leader>fn", "<cmd>Telescope docker networks<cr>", desc = "Docker networks" },
    },
  },

  -- Docker commands integration
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-command-palette.nvim",
    },
    config = function()
      require("telescope").load_extension("command_palette")
    end,
  },
} 