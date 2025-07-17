-- lua/plugins/project.lua
-- Gestión de proyectos con project.nvim y Telescope

return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        patterns = { ".git", "package.json", "pyproject.toml", "Makefile", ".hg", ".svn", ".root", ".project" },
        show_hidden = true,
        silent_chdir = true,
        manual_mode = false,
      })
      -- Cargar extensión en telescope
      pcall(function()
        require("telescope").load_extension("projects")
      end)
      -- Keymap para abrir proyectos
      vim.keymap.set("n", "<leader>pp", ":Telescope projects<CR>", { desc = "Proyectos recientes" })
    end,
  },
} 