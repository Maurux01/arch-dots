-- Modern dashboard using dashboard-nvim for a professional IDE look
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      return {
        theme = "doom",
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { icon = "  ", desc = "Nuevo archivo", action = "ene | startinsert", key = "e" },
            { icon = "  ", desc = "Buscar archivos", action = "Telescope find_files", key = "f" },
            { icon = "  ", desc = "Archivos recientes", action = "Telescope oldfiles", key = "r" },
            { icon = "  ", desc = "Buscar texto", action = "Telescope live_grep", key = "g" },
            { icon = "  ", desc = "Explorador", action = "NvimTreeToggle", key = "n" },
            { icon = "  ", desc = "Configurar Neovim", action = "edit ~/.config/nvim/init.lua", key = "c" },
            { icon = "  ", desc = "Salir", action = "qa", key = "q" },
          },
          footer = {
            "⚡ Neovim listo para trabajar",
            "Arch Dots - Modern IDE Experience",
          },
        },
      }
    end,
    config = function(_, opts)
      require("dashboard").setup(opts)
    end,
  },
} 