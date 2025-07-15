-- lua/plugins/nvim-web-devicons.lua
-- Optimized nvim-web-devicons configuration for animations
return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false, -- Load immediately for better animation performance
    config = function()
      require('nvim-web-devicons').setup({
        -- Enable default icons
        default = true,
        
        -- Strict mode for better performance
        strict = true,
        
        -- Override default icons
        override = {
          -- File types
          lua = {
            icon = "󰢱",
            color = "#51a0cf",
            name = "Lua"
          },
          py = {
            icon = "󰌠",
            color = "#ffbc03",
            name = "Python"
          },
          js = {
            icon = "󰌞",
            color = "#f7df1e",
            name = "JavaScript"
          },
          ts = {
            icon = "󰛦",
            color = "#519aba",
            name = "TypeScript"
          },
          jsx = {
            icon = "󰜈",
            color = "#61dafb",
            name = "React"
          },
          tsx = {
            icon = "󰜈",
            color = "#61dafb",
            name = "ReactTS"
          },
          json = {
            icon = "󰘦",
            color = "#f1e05a",
            name = "Json"
          },
          yaml = {
            icon = "󰰳",
            color = "#cb171e",
            name = "Yaml"
          },
          markdown = {
            icon = "󰍔",
            color = "#519aba",
            name = "Markdown"
          },
          md = {
            icon = "󰍔",
            color = "#519aba",
            name = "Markdown"
          },
          txt = {
            icon = "󰈙",
            color = "#89e051",
            name = "Text"
          },
          conf = {
            icon = "󰒓",
            color = "#6d8086",
            name = "Conf"
          },
          lock = {
            icon = "󰌾",
            color = "#f1e05a",
            name = "Lock"
          },
          mp4 = {
            icon = "󰈫",
            color = "#ff4db3",
            name = "Mp4"
          },
          webm = {
            icon = "󰈫",
            color = "#ff4db3",
            name = "Webm"
          },
          mkv = {
            icon = "󰈫",
            color = "#ff4db3",
            name = "Mkv"
          },
          webp = {
            icon = "󰈫",
            color = "#ff4db3",
            name = "Webp"
          },
          mp3 = {
            icon = "󰈣",
            color = "#d3a5c9",
            name = "Mp3"
          },
          flac = {
            icon = "󰈣",
            color = "#d3a5c9",
            name = "Flac"
          },
          wav = {
            icon = "󰈣",
            color = "#d3a5c9",
            name = "Wav"
          },
          -- Directories
          [".git"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "Git"
          },
          [".github"] = {
            icon = "󰊢",
            color = "#ffffff",
            name = "GitHub"
          },
          [".gitignore"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitIgnore"
          },
          [".gitattributes"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitAttributes"
          },
          [".gitmodules"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitModules"
          },
          [".gitmessage"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitMessage"
          },
          [".git-blame*"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitBlame"
          },
          [".git"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "Git"
          },
          [".github"] = {
            icon = "󰊢",
            color = "#ffffff",
            name = "GitHub"
          },
          [".gitignore"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitIgnore"
          },
          [".gitattributes"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitAttributes"
          },
          [".gitmodules"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitModules"
          },
          [".gitmessage"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitMessage"
          },
          [".git-blame*"] = {
            icon = "󰊢",
            color = "#f14c28",
            name = "GitBlame"
          },
        },
        
        -- Color devicons
        color_icons = true,
        
        -- Default icon
        default_icon = {
          icon = "󰈚",
          name = "Default"
        },
        
        -- Glob pattern
        glob_icons = true,
      })
    end,
  },
} 