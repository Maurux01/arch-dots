-- lua/plugins/surround.lua
-- Configuración personalizada de surround

return {
  "kylechui/nvim-surround",
  opts = {
    keymaps = {
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "ys",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
    keymaps_style = "surround",
    aliases = {
      ["a"] = { "(", ")" },
      ["b"] = { "(", ")" },
      ["B"] = { "{", "}" },
      ["r"] = { "[", "]" },
      ["q"] = { '"', '"' },
      ["s"] = { "'", "'" },
      ["t"] = { "<", ">" },
    },
    highlight = {
      duration = 0,
    },
  },
} 